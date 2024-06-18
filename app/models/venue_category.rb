class VenueCategory < ApplicationRecord
  validates :main_category, presence: true, uniqueness: true
end
