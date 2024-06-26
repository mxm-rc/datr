class Meet < ApplicationRecord
  belongs_to :accointance
  has_many :meet_venue_categories
  has_many :venue_categories, through: :meet_venue_categories
  validates :date, presence: true
  validates :venue_categories, presence: true
end
