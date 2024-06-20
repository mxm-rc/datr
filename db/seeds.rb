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
puts "Created #{users.count} Users"

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
puts "Created #{accointances.count} Accointances"

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
puts "Created #{meets.count} Meetings"

# Parse locations from geojson files
parsed_locations = parse_location_data

# Extract unique types from parsed_locations
# Unique_location_types: [
# Jardin(55), Cinéma(89), fountain(291), memorial(1050), tomb(587), optical_telegraph(1), place_of_worship(394),
# monastery(4), wayside_cross(6), yes(109), wayside_shrine(4), crime_scene(4), highwater_mark(10), house(2), tree(2),
# archaeological_site(3), monument(61), ruins(21), battlefield(2), milestone(2), castle(13), citywalls(1), building(83),
# river_mark(3), cafe(2148), cannon(18), shieling(1), aircraft(1), manor(38), mansion(1), city_gate(2), tower(2),
# chapel(1), palace(1), statue(2), church(2), ship(1), wall(1), bar(1804), restaurant(8369), pub(302), fast_food(2609),
# ice_cream(93), food_court(9) ]
parsed_locations.map { |location| location[:type] }.uniq.each do |type|
  VenueCategory.find_or_create_by(main_category: type, sub_category: "")
end
puts "Created #{VenueCategory.count} VenueCategories"

# Preload VenueCategories into a hash with main_category as the key
venue_categories_by_type = VenueCategory.all.index_by(&:main_category)

parsed_locations.each do |location|
  # Create Location
  new_location = Location.create!(
    location_type: location[:type],
    name: location[:name],
    city: "Paris",
    lon: location[:coordinates][:long],
    lat: location[:coordinates][:lat],
    picture: '/quartier-libre.jpg', # Assuming this is the correct path
    punchline: 'Pour des soirées un peu plus hot !'
  )

  # Attempt to find a matching VenueCategory
  venue_category = venue_categories_by_type[location[:type]]

  if venue_category
    # Create a LocationCategory
    LocationCategory.find_or_create_by(location: new_location, venue_category: venue_category)
  else
    puts "No matching VenueCategory found for location type: #{location[:type]}"
  end
end
puts "Created #{Location.count} Locations"
puts "Created #{LocationCategory.count} LocationCategories"

# Find the VenueCategory for "restaurant" as sample for tests
restaurant_category = VenueCategory.find_by(main_category: "restaurant")

# Create venue_preference in bulk
venue_preferences = [
  { user_id: users[0].id, venue_category_id: restaurant_category.id, preference_level: 1 },
  { user_id: users[3].id, venue_category_id: restaurant_category.id, preference_level: 1 }
]
venue_preferences.each do |preference|
  VenuePreference.create!(preference)
end
puts "Created #{VenuePreference.count} VenuePreferences"

puts "Database seeded successfully!"
