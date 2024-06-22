require_relative 'seeds_helpers'

# Destroy all records in a single transaction
[Meet, Accointance, Location, VenuePreference, VenueCategory, LocationCategory, User].each(&:destroy_all)

# Create users in bulk
users = User.create!(
  [{
    birthdate: Date.new(1994, 10, 18),
    pseudo: "mxm-rc",
    first_name: "Maxime",
    last_name: "Robert Colin",
    email: "maximerobertcolin@gmail.com",
    password: "maximerobertcolin@gmail.com",
    password_confirmation: "maximerobertcolin@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  }, {
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
  }, {
    birthdate: Date.new(1993, 4, 14),
    pseudo: "MaxFroh10",
    first_name: "Maxence",
    last_name: "Frohlicher",
    email: "maxence.frohlicher@icloud.com",
    password: "maxence.frohlicher@icloud.com",
    password_confirmation: "maxence.frohlicher@icloud.com",
    address: "10 boulevard de la villette, 75019, Paris",
    picture: "maxence.jpg",
    admin: "true"
  }, {
    birthdate: Date.new(1970, 7, 14),
    pseudo: "ChristopheMarco",
    first_name: "Christophe",
    last_name: "Marco",
    email: "christophe.marco@net-c.fr",
    password: "christophe.marco@net-c.fr",
    password_confirmation: "christophe.marco@net-c.fr",
    address: "10 boulevard de la villette, 75019, Paris",
    picture: "christophe.jpg",
    admin: "true"
  },{
    birthdate: Date.new(1994, 10, 18),
    pseudo: "Nico",
    first_name: "Nicolas",
    last_name: "Martin",
    email: "nicolasmartin@gmail.com",
    password: "nicolasmartin@gmail.com",
    password_confirmation: "nicolasmartin@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  },{
    birthdate: Date.new(1994, 10, 18),
    pseudo: "SexyLady",
    first_name: "Anne",
    last_name: "Hidalgo",
    email: "annehidalgo@gmail.com",
    password: "annehidalgo@gmail.com",
    password_confirmation: "annehidalgo@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  },{
    birthdate: Date.new(1994, 10, 18),
    pseudo: "Jean",
    first_name: "Jean",
    last_name: "Bon",
    email: "jeanbon@gmail.com",
    password: "jeanbon@gmail.com",
    password_confirmation: "jeanbon@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  }, {
    birthdate: Date.new(1994, 10, 18),
    pseudo: "Natatchouin",
    first_name: "Natacha",
    last_name: "Tchouin",
    email: "natatchouin@gmail.com",
    password: "natatchouin@gmail.com",
    password_confirmation: "natatchouin@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  }, {
    birthdate: Date.new(1994, 10, 18),
    pseudo: "Elisette",
    first_name: "Elisa",
    last_name: "Cou",
    email: "elisacou@gmail.com",
    password: "elisacou@gmail.com",
    password_confirmation: "elisacou@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  }, {
    birthdate: Date.new(1994, 10, 18),
    pseudo: "Michou",
    first_name: "Michelle",
    last_name: "Mabelle",
    email: "michellemabelle@gmail.com",
    password: "michellemabelle@gmail.com",
    password_confirmation: "michellemabelle@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  } , {
    birthdate: Date.new(1994, 10, 18),
    pseudo: "Bella",
    first_name: "Isabelle",
    last_name: "Adjani",
    email: "isabelleadjani@gmail.com",
    password: "isabelleadjani@gmail.com",
    password_confirmation: "isabelleadjani@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  }, {
    birthdate: Date.new(1994, 10, 18),
    pseudo: "PokerFace",
    first_name: "Lady",
    last_name: "Gaga",
    email: "ladygaga@gmail.com",
    password: "ladygaga@gmail.com",
    password_confirmation: "ladygaga@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  }, {
    birthdate: Date.new(1994, 10, 18),
    pseudo: "Star",
    first_name: "Celine",
    last_name: "Dion",
    email: "celinedion@gmail.com",
    password: "celinedion@gmail.com",
    password_confirmation: "celinedion@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  }, {
    birthdate: Date.new(1994, 10, 18),
    pseudo: "NakedSlut",
    first_name: "Katy",
    last_name: "Perry",
    email: "katyperry@gmail.com",
    password: "katyperry@gmail.com",
    password_confirmation: "katyperry@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  }, {
    birthdate: Date.new(1994, 10, 18),
    pseudo: "BigD",
    first_name: "Grant",
    last_name: "Ducati",
    email: "grantducati@gmail.com",
    password: "grantducati@gmail.com",
    password_confirmation: "grantducati@gmail.com",
    address: "47 rue des rosiers, 93400, Saint-Ouen",
    picture: "maxime.jpg",
    admin: "true"
  }]
)
puts "Created : #{users.count} Users"

# Create accointances in bulk
accointances = Accointance.create!(
  [{
    follower: users[0], recipient: users[1], status: 'pending'
  }, {
    follower: users[0], recipient: users[2], status: 'accepted'
  }, {
    follower: users[0], recipient: users[3], status: 'refused'
   }, {
     follower: users[1], recipient: users[2], status: 'accepted'
   }, {
     follower: users[1], recipient: users[3], status: 'pending'
   }, {
     follower: users[2], recipient: users[3], status: 'refused'
   }, {
     follower: users[5], recipient: users[2], status: 'accepted'
   }, {
     follower: users[6], recipient: users[2], status: 'accepted'
   }, {
     follower: users[7], recipient: users[2], status: 'accepted'
   }, {
     follower: users[8], recipient: users[2], status: 'accepted'
   }]
)
puts "Created : #{accointances.count} Accointances"

# Create meets in bulk
meets = Meet.create!(
  [{
    accointance: accointances.first,
    centered_address_long: -12_345_678,
    centered_address_lat: 12_345_678,
    status: 'planned',
    date: Date.today + 7.days
  }]
)
puts "Created : #{meets.count} Meetings"

# Parse locations coming from geojson files
# parsed_locations = parse_location_data

# Parse locations coming from our personal parsed json file
parsed_locations = read_our_json_file
puts 'Parsed locations are uploaded from our personal JSON file !'

parsed_locations.map { |location| location[:type] }.uniq.each do |type|
  VenueCategory.find_or_create_by(main_category: type, sub_category: "")
end
puts "Created : #{VenueCategory.count} VenueCategories"

puts 'Locations Bulk inserting in DB...'
# Prepare data for bulk insertion to speed-up the seeding
location_data = parsed_locations.map do |location|
  {
    location_type: location[:type],
    name: location[:name],
    address: "1 rue xxxx",
    zip_code: "75xxx",
    city: "Paris",
    price_range: "€€",
    lon: location[:coordinates][:long],
    lat: location[:coordinates][:lat],
    picture: location[:picture],
    punchline: 'Pour des soirées un peu plus hot !',
    created_at: Time.current,
    updated_at: Time.current
  }
end
# Bulk insert locations and retrieve them with IDs
Location.insert_all(location_data)
puts "Created : #{Location.count} Locations"

puts 'Locations Categories Bulk inserting in DB...'
# Preload all VenueCategories and index them by main_category for quick lookup
venue_categories_by_main_category = VenueCategory.all.index_by(&:main_category)
# Initialize an array to hold the data for bulk insertion
location_categories_data = []
Location.find_each do |place|
  v_category = venue_categories_by_main_category[place.location_type]

  if v_category
    location_categories_data << { location_id: place.id, venue_category_id: v_category.id, created_at: Time.current, updated_at: Time.current }
  else
    puts "No matching VenueCategory found for location type: #{place.location_type}"
  end
end
# Bulk insert LocationCategory records if there are any to create
LocationCategory.insert_all(location_categories_data) unless location_categories_data.empty?
puts "Created : #{LocationCategory.count} LocationCategories"

# Find the VenueCategory for "restaurant" as sample for tests
restaurant_category = VenueCategory.find_by(main_category: "Restaurant")

# Create venue_preference in bulk
venue_preferences = [
  { user_id: users[0].id, venue_category_id: restaurant_category.id, preference_level: 1 },
  { user_id: users[3].id, venue_category_id: restaurant_category.id, preference_level: 1 }
]
venue_preferences.each do |preference|
  VenuePreference.create!(preference)
end
puts "Created : #{VenuePreference.count} VenuePreferences"

puts "Database seeded successfully!"
