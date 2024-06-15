class CreateLocationCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :location_categories do |t|
      t.references :location, null: false, foreign_key: true
      t.references :venue_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
