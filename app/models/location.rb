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
  def self.recommended_locations(my_id, friend_id, mid_point, limit)
    # 1 Determine common preferences between me and friend
    common_categories = find_joker(my_id, friend_id).presence || find_common_categories(my_id, friend_id)
    # Print common categories
    my_puts("recommended_locations.common_categories: #{common_categories.map(&:main_category)}")

    # 2 Filter the locations based on the common preferences
    locations = find_location(common_categories)

    # 3 return closest places of mid point limited to the limit
    sorted_locations = sort_by_proximity_to_midpoint(locations, mid_point)
    sorted_locations.first(limit)
  end

  def self.find_common_categories(my_id, friend_id)
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

  def self.sort_by_proximity_to_midpoint(locations, midpoint)
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
