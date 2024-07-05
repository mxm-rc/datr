class Location < ApplicationRecord
  # Associations
  has_many :selected_places, dependent: :destroy
  has_many :location_categories, dependent: :destroy
  has_many :venue_categories, through: :location_categories, dependent: :destroy

  def self.allowed_types
    {
      "Surprise" => ActionController::Base.helpers.asset_path("location_types/surprise.jpg"),
      "Bar" => ActionController::Base.helpers.asset_path("location_types/bar.avif"),
      "Cafe" => ActionController::Base.helpers.asset_path("location_types/cafe.jpg"),
      "Chateau" => ActionController::Base.helpers.asset_path("location_types/castle.jpg"),
      "Cinema" => ActionController::Base.helpers.image_path("location_types/movies.avif"),
      "Glacier" => ActionController::Base.helpers.asset_path("location_types/ice_cream.jpg"),
      "Jardin" => ActionController::Base.helpers.asset_path("location_types/garden.jpg"),
      "Monument" => ActionController::Base.helpers.asset_path("location_types/monument.jpg"),
      "Restauration rapide" => ActionController::Base.helpers.asset_path("location_types/fast_food.jpg"),
      "Restaurant" => ActionController::Base.helpers.asset_path("location_types/restaurant.jpg")
    }
  end

  # Method to fetch recommended Locations based on common Categories between two users
  def self.recommended_locations(my_id, friend_id, mid_point, limit, categories)
    if categories.present?
      # Use categories selected by the user
      common_categories = categories
    else
      # Find common categories between users
      common_categories = find_common_categories(my_id, friend_id)
    end
    if common_categories.include?(VenueCategory.find_by(main_category: 'Surprise'))
      # If 'Surprise' category is present in common_categories then common_categories is all categories randomly aranged
      common_categories = VenueCategory.all.sample(4)
    end
    my_puts("recommended_locations.common_categories: #{common_categories.map(&:main_category)}")


    # 2 Filter the locations based on the common preferences
    locations = find_location(common_categories)

    # 3 return closest places of mid point limited to the limit
    # sorted_locations = sort_by_proximity_to_midpoint(locations, mid_point).first(limit)
    sorted_locations = sort_by_proximity_to_midpoint(locations, mid_point)

    final_locations = []
    if sorted_locations.present?
      final_locations = pick_locations(sorted_locations, limit, common_categories.map(&:main_category))
    end
    final_locations
  end

  def self.pick_locations(sorted_locations, limit, common_categories)
    selected_locations = []
    locations_by_category = sorted_locations.group_by(&:location_type)

    # Initialize categories_picked array
    categories_picked = []

    # Try to pick at least one location from each preferred category
    common_categories.each do |category|
      if locations_by_category[category].present?
        # Get first element from array, remove it in array and send it to selected_location
        selected_location = locations_by_category[category].shift
        selected_locations << selected_location unless selected_locations.include?(selected_location)
        categories_picked << category # Add category to categories_picked
        break if selected_locations.size >= limit
        end
    end

    # Fill selected_locations with locations from categories alternatively, if we haven't reached the limit
    while selected_locations.size < limit
      any_location_added = false

      common_categories.each do |category|
        next if locations_by_category[category].blank? || !categories_picked.include?(category)

        selected_location = locations_by_category[category].shift
        if selected_location
          selected_locations << selected_location unless selected_locations.include?(selected_location)
          any_location_added = true
          break if selected_locations.size >= limit
        end
      end

      # Break the loop if no new location was added in the last iteration to prevent infinite loop
      break unless any_location_added
    end
    selected_locations
  end

  def self.find_common_categories(my_id, friend_id)
    # Determine common preferences between me and friend
    common_categories = find_joker(my_id, friend_id).presence || common_categories(my_id, friend_id)
  end

  def self.common_categories(my_id, friend_id)
    # Print all my_id categories
    my_puts("Location.find_common_categories: My_id Categories: #{VenuePreference.includes(:venue_category)
                                                                                 .where(user_id: my_id)
                                                                                 .map { |vp| vp.venue_category.main_category }
                                                                                 .uniq}")

    # Print all friend_id categories
    my_puts("Location.find_common_categories: Friend_id Categories: #{VenuePreference.includes(:venue_category)
                                                                                 .where(user_id: friend_id)
                                                                                 .map { |vp| vp.venue_category.main_category }
                                                                                 .uniq}")

    # Search common Categories for both users if no joker preferences found for both
    common_categories = VenuePreference.select(:venue_category_id)
                                       .where(user_id: [my_id, friend_id])
                                       .group(:venue_category_id)
                                       .having('COUNT(DISTINCT user_id) = 2')
                                       .map(&:venue_category)

    return common_categories unless common_categories.empty?

    # If no common Categories found for both users then use Categories from friend
    friend_categories = VenuePreference.where(user_id: friend_id)
                                       .map(&:venue_category)
    friend_categories.presence || []
  end

  def self.find_location(common_categories)
    category_ids = common_categories.map(&:id)
    Location.joins(:location_categories)
            .where(location_categories: { venue_category_id: category_ids })
            .distinct
  end

  def self.find_midpoint(me_id, friend_id)
    me = User.find(user_id: me_id)
    friend = User.find(user_id: friend_id)
    # Get the location in longitude and latitude from the user
    my_coordinates = {}
    my_coordinates[:lon] = me.lon
    my_coordinates[:lat] = me.lat

    friend_coordinates = {}
    friend_coordinates[:lon] = friend.lon
    friend_coordinates[:lat] = friend.lat

    # my_coordinates = { lat: 48.9046440, long: 2.3382141 } # Maxime
    # friend_coordinates = { lat: 48.8454382, long: 2.2668038 }

    midpoint_latitude = (my_coordinates[:lat] + friend_coordinates[:lat]) / 2.0
    midpoint_longitude = (my_coordinates[:long] + friend_coordinates[:long]) / 2.0
    # Midpoint
    midpoint = { lat: midpoint_latitude, long: midpoint_longitude }
    my_puts("find_midpoint: Midpoint: #{midpoint.inspect}")

    return midpoint
  end

  def self.sort_by_proximity_to_midpoint(locations, midpoint)
    my_puts("sort_by_proximity_to_midpoint Midpoint: #{midpoint.inspect}")
    locations.sort_by do |location|
      ((location.lat - midpoint.lat)**2) + ((location.lon - midpoint.lon)**2)
    end
  end

  def self.user_has_joker?(id)
    # Get 'Surprise' (=joker) category ID from VenueCategory
    key = allowed_types.keys.first
    joker_id = VenueCategory.find_by(main_category: key)&.id

    # return 'True' if the user has a joker preference
    VenuePreference.exists?(user_id: id, venue_category_id: joker_id)
  end

  def self.find_joker(my_id, friend_id)
    # Search joker presence both users
    my_joker = user_has_joker?(my_id)
    # Print joker presence for my
    my_puts("find_joker.Me : #{my_joker} !")

    friend_joker = user_has_joker?(friend_id)
    # Print joker presence for friend
    my_puts("find_joker.Friend : #{friend_joker} !")

    # If both users have joker preference then return full categories array
    return VenueCategory.all if my_joker && friend_joker

    # If my_id has joker preference then return array with all friend_id categories
    return VenuePreference.where(user_id: friend_id).map(&:venue_category) if my_joker

    # If friend_id has joker preference then return array with all my_id categories
    return VenuePreference.where(user_id: my_id).map(&:venue_category) if friend_joker

    # If no joker preference found for both users then return empty array
    return []
  end
end
