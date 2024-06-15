require 'json'
restaurant_json_file = File.open('app/assets/restaurant_database/restaurants-casvp.json').read

Accointance.destroy_all
User.destroy_all
Accointance.destroy_all
Meet.destroy_all
Location.destroy_all

# Creating users
user1 = User.create!(
  birthdate: Date.new(1994, 10, 18),
  pseudo: "mxm-rc",
  first_name: "Maxime",
  last_name: "Robert Colin",
  email: "maximerobertcolin@gmail.com",
  password: "maximerobertcolin@gmail.com",
  password_confirmation: "maximerobertcolin@gmail.com",
  address: "47 rue des rosiers, 93400, Saint-Ouen",
  picture: "maxime.jpg"
)

user2 = User.create!(
  birthdate: Date.new(1985, 7, 14),
  pseudo: "antoinehuret",
  first_name: "Antoine",
  last_name: "Huret",
  email: "huretantoine@gmail.com",
  password: "huretantoine@gmail.com",
  password_confirmation: "huretantoine@gmail.com",
  address: "10 boulevard de la villette, 75019, Paris",
  picture: "antoine.jpg",
  admin: "true"
)

user3 = User.create!(
  birthdate: Date.new(1993, 4, 14),
  pseudo: "MaxFroh10",
  first_name: "Maxence",
  last_name: "Frohlicher",
  email: "maxence.frohlicher@icloud.com",
  password: "maxence.frohlicher@icloud.com",
  password_confirmation: "maxence.frohlicher@icloud.com",
  address: "10 boulevard de la villette, 75019, Paris",
  picture: "maxence.jpg"
)

user4 = User.create!(
  birthdate: Date.new(1960, 7, 14),
  pseudo: "ChristopheMarco",
  first_name: "Christophe",
  last_name: "Marco",
  email: "christophe.marco@net-c.fr",
  password: "christophe.marco@net-c.fr",
  password_confirmation: "christophe.marco@net-c.fr",
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

# Création de rencontres (meets) associées à ces accointances
Meet.create!(
  accointance: Accointance.first,
  centered_address_long: -12_345_678,
  centered_address_lat: 12_345_678,
  status: 'planned',
  date: Date.today + 7.days
)
puts "Created #{Meet.count} Meeting"

restaurants = JSON.parse(restaurant_json_file)

restaurants.each_with_index do |restaurant_data, index|
  break if index >= 50 # Break the loop once 50 restaurants have been created

  tt_data = restaurant_data['tt']

  if tt_data.present? && tt_data.key?('lon') && tt_data.key?('lat')
    location = Location.new(
      zip_code: restaurant_data['code'],
      name: restaurant_data['nom_restaurant'],
      address: restaurant_data['adresse'],
      city: restaurant_data['ville'],
      lon: tt_data['lon'],
      lat: tt_data['lat'],
      location_type: 'Restaurant',
      price_range: '2',
      picture: '/quartier-libre.jpg', # Dans /Public
      punchline: 'Pour des soirées un peu plus hot !'
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
