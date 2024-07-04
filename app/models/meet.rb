class Meet < ApplicationRecord
  belongs_to :accointance
  has_many :meet_venue_categories, dependent: :destroy
  has_many :venue_categories, through: :meet_venue_categories
  validates :date, presence: true
  # Ca fait bogger la seed...
  # validates :venue_categories, presence: true

  def selected_place
    # Find selected place for this meet instance where selected_by_follower and selected_by_recipient are true
    SelectedPlace.where(meet_id: id, selected_by_follower: true, selected_by_recipient: true).first
  end
end
