class CreateMeets < ActiveRecord::Migration[7.1]
  def change
    create_table :meets do |t|
      t.references :accointance, null: false, foreign_key: true
      t.integer :centered_address_long
      t.integer :centered_address_lat
      t.string :status
      t.date :date

      t.timestamps
    end
  end
end
