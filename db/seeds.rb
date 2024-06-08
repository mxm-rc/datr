# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.create!([
  {
    birthdate: Date.new(1994, 10, 18),
    pseudo: "mxm-rc",
    first_name: "Maxime",
    last_name: "Robert Colin",
    email: "maximerobertcolin@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    address: "47 rue des rosiers, 93400, Saint-Ouen"
  },
  {
    birthdate: Date.new(1985, 7, 14),
    pseudo: "antoinehuret",
    first_name: "Antoine",
    last_name: "Huret",
    email: "huretantoine@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    address: "10 boulevard de la villette, 75019, Paris"
  },
  {
    birthdate: Date.new(1993, 4, 14),
    pseudo: "MaxFroh10",
    first_name: "Maxence",
    last_name: "Frohlicher",
    email: "maxence.frohlicher@icloud.com",
    password: "123456",
    password_confirmation: "123456",
    address: "10 boulevard de la villette, 75019, Paris"
  },
  {
    birthdate: Date.new(1960, 7, 14),
    pseudo: "ChristopheMarco",
    first_name: "Christophe",
    last_name: "Marco",
    email: "christophe.marco@net-c.fr",
    password: "123456",
    password_confirmation: "123456",
    address: "10 boulevard de la villette, 75019, Paris"
  }
])

puts "Created #{User.count} Users"

Accointance.create!(
  {
    follower_id: 3,
    recipient_id: 2,
    status: "confirmed"
  }
)
  # Meet.create(
  # {
  #   id_acquaintances: 1,
  #   follower_id: 101,
  #   receiver_id: 202,
  #   centered_address_long: -122.4194,
  #   centered_address_lat: 37.7749,
  #   status: "confirmed",
  #   date: Date.new(2024, 6, 10)
  # },
  # {
  #   id_acquaintances: 2,
  #   follower_id: 103,
  #   receiver_id: 204,
  #   centered_address_long: -74.0060,
  #   centered_address_lat: 40.7128,
  #   status: "pending",
  #   date: Date.new(2024, 7, 1)
  # },
  # {
  #   id_acquaintances: 3,
  #   follower_id: 105,
  #   receiver_id: 206,
  #   centered_address_long: 139.6917,
  #   centered_address_lat: 35.6895,
  #   status: "cancelled",
  #   date: Date.new(2024, 8, 15)
  # })
