class Location < ApplicationRecord
  # Associations
  has_many :selected_places, dependent: :destroy

  def range_to_price
    case price_range
    when '0'
      '0-9€'
    when '1'
      '10-19€'
    when '2'
      '20-29€'
    else
      "Prix non spécifié"
    end
  end
end
