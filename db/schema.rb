# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_11_175744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accointances", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "recipient_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id"], name: "index_accointances_on_follower_id"
    t.index ["recipient_id"], name: "index_accointances_on_recipient_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "price_range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zip_code"
    t.string "city"
    t.float "lon"
    t.float "lat"
    t.string "location_type"
    t.string "picture"
    t.string "punchline"
  end

  create_table "meets", force: :cascade do |t|
    t.bigint "accointance_id", null: false
    t.integer "centered_address_long"
    t.integer "centered_address_lat"
    t.string "status"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accointance_id"], name: "index_meets_on_accointance_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "accointance_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accointance_id"], name: "index_messages_on_accointance_id"
  end

  create_table "selected_places", force: :cascade do |t|
    t.bigint "meet_id", null: false
    t.bigint "location_id", null: false
    t.boolean "selected_by_follower"
    t.boolean "selected_by_recipient"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_selected_places_on_location_id"
    t.index ["meet_id"], name: "index_selected_places_on_meet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pseudo"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "picture"
    t.date "birthdate"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accointances", "users", column: "follower_id"
  add_foreign_key "accointances", "users", column: "recipient_id"
  add_foreign_key "meets", "accointances"
  add_foreign_key "messages", "accointances"
  add_foreign_key "selected_places", "locations"
  add_foreign_key "selected_places", "meets"
end
