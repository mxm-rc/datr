class CreateVenueCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :venue_categories do |t|
      t.string :main_category
      t.string :sub_category

      t.timestamps
    end
  end
end
