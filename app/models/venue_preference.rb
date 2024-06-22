class VenuePreference < ApplicationRecord
  validates :user_id, presence: true
  validates :venue_category_id, presence: true

  # Possible to prioritize a preference in preference list
  validates :preference_level, presence: true, numericality: { only_integer: true }

  # Assuming relationships are defined like this:
  belongs_to :user
  belongs_to :venue_category

  before_validation :set_default_preference_level, if: -> { preference_level.blank? }

  private

  def set_default_preference_level
    self.preference_level = 1
  end
end
