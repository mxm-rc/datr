class LocationCategory < ApplicationRecord
  # Ensures location_id and venue_category_id are present and only unique pairs are allowed
  validates :location_id, presence: true
  validates :venue_category_id, presence: true, uniqueness: { scope: :location_id }

  belongs_to :location
  belongs_to :venue_category
end
