class Location < ApplicationRecord
  # Associations
  has_many :selected_places, dependent: :destroy
  has_many :location_categories
  has_many :venue_categories, through: :location_categories

  def range_to_price
    price_map = {
      '0' => '0-9€',
      '1' => '10-19€',
      '2' => '20-29€'
    }
    price_map[price_range] || "Prix non spécifié"
  end

  # Method to fetch recommended Locations based on common Categories between two users
  def self.recommended_locations(my_id, friend_id, limit)
    # Step 1: Find common Categories for me and my friend
    common_categories_ids = find_common_categories(my_id, friend_id)

    # Ensure there are common categories before to proceed step 2
    return [] if common_categories_ids.empty?

    # Step 2: Find Unique Locations matching common Categories
    location_ids = find_location_ids(common_categories_ids)

    # Step 3: Fetch recommended Locations, Randomize and Limit according to limit parameter
    # For small dataset .shuffle for randomization is less time consuming than ORDER BY RANDOM()
    Location.where(id: location_ids).limit(limit).to_a.shuffle
  end

  def self.find_common_categories(my_id, friend_id)
    # Search common Categories for both users
    common_categories_ids = VenuePreference
                            .where(user_id: [my_id, friend_id])
                            .group(:venue_categories_id)
                            .having('COUNT(DISTINCT user_id) = 2')
                            .pluck(:venue_categories_id)

    # If no common Categories found for both users then use Categories from friend
    VenuePreference.where(user_id: friend_id).pluck(:venue_categories_id) if common_categories_ids.empty?
  end

  def self.find_location_ids(common_categories_ids)
    LocationCategory
      .where(venue_category_id: common_categories_ids)
      .distinct
      .pluck(:location_id)
  end
end
