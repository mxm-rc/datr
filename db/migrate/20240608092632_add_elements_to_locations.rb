class AddElementsToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :zip_code, :string
    add_column :locations, :city, :string
    add_column :locations, :lon, :float
    add_column :locations, :lat, :float
    remove_column :locations, :type, :string
    add_column :locations, :location_type, :string
  end
end
