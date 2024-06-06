class CreateSelectedPlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :selected_places do |t|
      t.references :meet, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.boolean :selected_by_follower
      t.boolean :selected_by_recipient

      t.timestamps
    end
  end
end
