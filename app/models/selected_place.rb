class SelectedPlace < ApplicationRecord
  belongs_to :meet
  belongs_to :location
end
