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
