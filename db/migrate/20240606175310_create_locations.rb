class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :type
      t.string :name
      t.string :address
      t.string :price_range

      t.timestamps
    end
  end
end
