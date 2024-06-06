class CreateAccointances < ActiveRecord::Migration[7.1]
  def change
    create_table :accointances do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users}
      t.references :recipient, null: false, foreign_key: { to_table: :users}
      t.string :status

      t.timestamps
    end
  end
end
