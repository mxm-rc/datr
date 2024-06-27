class MeetVenueCategory < ApplicationRecord
  belongs_to :meet
  belongs_to :venue_category
end
