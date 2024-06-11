class AddPhotoUrlAndPunchlineToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :picture, :string
    add_column :locations, :punchline, :string
  end
end
