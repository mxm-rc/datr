class CreateMeetVenueCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :meet_venue_categories do |t|
      t.references :meet, null: false, foreign_key: true
      t.references :venue_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
