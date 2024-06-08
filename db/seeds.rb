require 'json'
restaurant_json_file = File.open('app/assets/restaurant_database/restaurants-casvp.json').read

Accointance.destroy_all
User.destroy_all
Accointance.destroy_all
Location.destroy_all

# Creating users
user1 = User.create!(
  birthdate: Date.new(1994, 10, 18),
  pseudo: "mxm-rc",
  first_name: "Maxime",
  last_name: "Robert Colin",
  email: "maximerobertcaaaozlin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  address: "47 rue des rosiers, 93400, Saint-Ouen",
  picture: "maxime.jpg"
)

user2 = User.create!(
  birthdate: Date.new(1985, 7, 14),
  pseudo: "antoinehuret",
  first_name: "Antoine",
  last_name: "Huret",
  email: "huretantoine@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  address: "10 boulevard de la villette, 75019, Paris",
  picture: "antoine.jpg"
)

user3 = User.create!(
  birthdate: Date.new(1993, 4, 14),
  pseudo: "MaxFroh10",
  first_name: "Maxence",
  last_name: "Frohlicher",
  email: "maxence.frohlicher@icloud.com",
  password: "123456",
  password_confirmation: "123456",
  address: "10 boulevard de la villette, 75019, Paris",
  picture: "maxence.jpg"
)

user4 = User.create!(
  birthdate: Date.new(1960, 7, 14),
  pseudo: "ChristopheMarco",
  first_name: "Christophe",
  last_name: "Marco",
  email: "christophe.marco@net-c.fr",
  password: "123456",
  password_confirmation: "123456",
  address: "10 boulevard de la villette, 75019, Paris",
  picture: "christophe.jpg"
)

puts "Created #{User.count} Users"

Accointance.create!(follower: user1, recipient: user2, status: 'pending')
Accointance.create!(follower: user1, recipient: user3, status: 'accepted')
Accointance.create!(follower: user1, recipient: user4, status: 'refused')
Accointance.create!(follower: user2, recipient: user3, status: 'accepted')
Accointance.create!(follower: user2, recipient: user4, status: 'pending')
Accointance.create!(follower: user3, recipient: user4, status: 'refused')

puts "Created #{Accointance.count} Accointances"

restaurants = JSON.parse(restaurant_json_file)

restaurants.each_with_index do |restaurant_data, index|
  break if index >= 50  # Break the loop once 50 restaurants have been created

  tt_data = restaurant_data['tt']

  if tt_data.present? && tt_data.key?('lon') && tt_data.key?('lat')
    location = Location.new(
      zip_code: restaurant_data['code'],
      name: restaurant_data['nom_restaurant'],
      address: restaurant_data['adresse'],
      city: restaurant_data['ville'],
      lon: tt_data['lon'],
      lat: tt_data['lat'],
      location_type: restaurant_data['type']
    )

    if location.save
      puts "Restaurant '#{location.name}' created successfully."
    else
      puts "Failed to create restaurant '#{location.name}'. Errors: #{location.errors.full_messages}"
    end
  else
    puts "Skipping restaurant '#{restaurant_data['nom_restaurant']}' due to missing or incomplete location data."
  end
end

puts "Created #{Location.count} Locations"
