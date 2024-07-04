class ChangeCenteredAddressToFloatInMeets < ActiveRecord::Migration[7.1]
  def change
    # Change columns in meets table
    change_column :meets, :centered_address_long, :float
    change_column :meets, :centered_address_lat, :float

    # Add columns to users table
    add_column :users, :lon, :float
    add_column :users, :lat, :float
  end
end
