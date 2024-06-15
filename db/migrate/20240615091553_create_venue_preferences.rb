class CreateVenuePreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :venue_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :venue_category, null: false, foreign_key: true
      t.integer :preference_level

      t.timestamps
    end
  end
end
