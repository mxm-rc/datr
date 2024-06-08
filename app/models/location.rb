class Location < ApplicationRecord
  # Associations
  has_many :selected_places, dependent: :destroy
end
