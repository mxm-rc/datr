class VenueCategory < ApplicationRecord
  validates :main_category, presence: true, uniqueness: true
  validates :sub_category, presence: true, uniqueness: { scope: :main_category }
end
