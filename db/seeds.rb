require 'json'

Meet.destroy_all
Accointance.destroy_all
User.destroy_all
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
  picture: "maxime.jpg",
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
  picture: "maxence.jpg",
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
  picture: "christophe.jpg",
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


allotment_filepath = "./db/seed_geojson/allotments.geojson"
serialized_allotments = File.read(allotment_filepath)
allotments = JSON.parse(serialized_allotments)

cinemas_filepath = "./db/seed_geojson//cinemas.geojson"
serialized_cinemas = File.read(cinemas_filepath)
cinemas = JSON.parse(serialized_cinemas)

historics_filepath = "./db/seed_geojson/historics.geojson"
serialized_historics = File.read(historics_filepath)
historics = JSON.parse(serialized_historics)

restaurants_filepath = "./db/seed_geojson/restaurants.geojson"
serialized_restaurants = File.read(restaurants_filepath)
restaurants = JSON.parse(serialized_restaurants)

parsed_restaurants = restaurants["features"].map do |restaurant|
  {
    type: restaurant["properties"]["type"],
    name: restaurant["properties"]["name"],
    phone: restaurant["properties"]["phone"],
    website: restaurant["properties"]["website"],
    coordinates:
      {
        long: restaurant["geometry"]["coordinates"][0],
        lat: restaurant["geometry"]["coordinates"][1]
      }
  }
end

parsed_historics = historics["features"].map do |historic|
  {
    type: historic["properties"]["type"],
    name: historic["properties"]["name"],
    coordinates: {
      long: historic["geometry"]["coordinates"][0],
      lat: historic["geometry"]["coordinates"][1]
    }
  }
end

parsed_allotments = allotments["features"].map do |allotment|
  {
    type: "Jardin",
    name: allotment["properties"]["name"],
    coordinates: {
      long: allotment["geometry"]["coordinates"][0],
      lat: allotment["geometry"]["coordinates"][1]
    }
  }
end

parsed_cinemas = cinemas["features"].map do |cinema|
  {
    type: "Cinéma",
    name: cinema["properties"]["name"],
    website: cinema["properties"]["website"],
    phone: cinema["properties"]["phone"],
    coordinates: {
      long: cinema["geometry"]["coordinates"][0],
      lat: cinema["geometry"]["coordinates"][1]
    }
  }
end

parsed_locations = [parsed_allotments, parsed_cinemas, parsed_historics, parsed_restaurants].flatten
parsed_locations.each do |location|
  Location.create!(
    location_type: location[:type],
    name: location[:name],
    city: "Paris",
    lon: location[:coordinates][:long],
    lat: location[:coordinates][:lat]
  )
end

puts "Created #{Location.count} Locations"
