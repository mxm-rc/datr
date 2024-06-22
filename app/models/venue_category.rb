class VenueCategory < ApplicationRecord
  validates :main_category, presence: true, uniqueness: true
  has_many :venue_preferences
  has_many :location_categories
end
