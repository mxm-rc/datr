require_relative 'seeds_helpers'

# Destroy all records in a single transaction
[SelectedPlace, Meet, Accointance, Location, VenuePreference, VenueCategory, LocationCategory, User].each(&:destroy_all)

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
    admin: "true",
    bio: "Je suis un développeur web sportif et super sexi. Passionné par les nouvelles technologies et les jeux vidéos mais aussi et surtout la musique et les sorties entre amis.",
    lat: 48.9046440,
    lon: 2.3382141
    }, {
    birthdate: Date.new(1985, 7, 14),
    pseudo: "emma",
    first_name: "Emmanuelle",
    last_name: "Course",
    email: "huretantoine@gmail.com",
    password: "huretantoine@gmail.com",
    password_confirmation: "huretantoine@gmail.com",
    address: "10 boulevard de la villette, 75019, Paris",
    picture: "emmanuelle.jpg",
    admin: "true",
    bio: "Je suis jeune, belle et sportive ;) passionnée par la mode et les sorties entre amis. J'aime aussi les soirées entre filles et les bons restos.",
    lat: 48.8454382,
    lon: 2.2668038
  }, {
    birthdate: Date.new(1993, 5, 10),
    pseudo: "Agatha",
    first_name: "Agathe",
    last_name: "Dumoulin",
    email: "maxence.frohlicher@icloud.com",
    password: "maxence.frohlicher@icloud.com",
    password_confirmation: "maxence.frohlicher@icloud.com",
    address: "58v Rue Mirabeau, 75016 Paris",
    picture: "agathe.jpg",
    admin: "true",
    bio: "Je suis spécialiste en marketing digital. Passionnée de voyages et de photographie, j'ai aussi cofondé une association dédiée à l'autonomisation des femmes dans le secteur technologique.",
    lat: 48.8454382,
    lon: 2.2668038
    }, {
    birthdate: Date.new(1998, 2, 20),
    pseudo: "Est3lle",
    first_name: "Estelle",
    last_name: "Luin",
    email: "christophe.marco@net-c.fr",
    password: "christophe.marco@net-c.fr",
    password_confirmation: "christophe.marco@net-c.fr",
    address: "8 rue Pecquay, 75004, Paris",
    picture: "estelle.jpg",
    admin: "true",
    bio: "Je suis étudiante en droit et j'aime faire la fête sans me prendre la tête.",
    lat: 48.8454382,
    lon: 2.2668038
  },{
    birthdate: Date.new(1990, 3, 8),
    pseudo: "LolitaBanana",
    first_name: "Axelle",
    last_name: "Martin",
    email: "axellemartin@gmail.com",
    password: "axellemartin@gmail.com",
    password_confirmation: "axellemartin@gmail.com",
    address: "105 boulevard Voltaire, 75011, Paris",
    picture: "axelle.jpg",
    admin: "true",
    bio: "Hâte de te rencontrer en vrai ! Je ne suis pas difficile, fais-moi rêver.",
    lat: 48.8454382,
    lon: 2.2668038
  },{
    birthdate: Date.new(1994, 1, 1),
    pseudo: "Annette",
    first_name: "Anne",
    last_name: "Suon",
    email: "annesuon@gmail.com",
    password: "annesuon@gmail.com",
    password_confirmation: "annesuon@gmail.com",
    address: "52 rue de Montreuil, 75012, Paris",
    picture: "anne.jpg",
    admin: "true",
    bio: "Je suis une femme simple mais exigeante. J'aime manger de tout.",
    lat: 48.8454382,
    lon: 2.2668038
  },{
    birthdate: Date.new(1995, 10, 10),
    pseudo: "Maria",
    first_name: "Marie",
    last_name: "Laine",
    email: "marielaine@gmail.com",
    password: "marielaine@gmail.com",
    password_confirmation: "marielaine@gmail.com",
    address: "67 boulevard Vincent Auriol, 75013, Paris",
    picture: "marie.jpg",
    admin: "true",
    bio: "Je n'ai rien à dire, je te laisse me découvrir par toi-même.",
    lat: 48.8454382,
    lon: 2.2668038
  }, {
    birthdate: Date.new(2000, 8, 8),
    pseudo: "NatMin",
    first_name: "Natacha",
    last_name: "Minot",
    email: "natatchouin@gmail.com",
    password: "natatchouin@gmail.com",
    password_confirmation: "natatchouin@gmail.com",
    address: "30 rue Mazarine, 75006, Paris",
    picture: "natacha.jpg",
    admin: "true",
    bio: "Je ne connais pas du tout mon quartier. J'aimerais rencontrer des gens pour m'aider à le découvrir.",
    lat: 48.8454382,
    lon: 2.2668038
  }, {
    birthdate: Date.new(1989, 9, 26),
    pseudo: "Mymycou",
    first_name: "Mylène",
    last_name: "Cou",
    email: "mylenecou@gmail.com",
    password: "mylenecou@gmail.com",
    password_confirmation: "mylenecou@gmail.com",
    address: "24 rue Vanneau, 75007, Paris",
    picture: "mylene.jpg",
    admin: "true",
    bio: "Plus j'en dis de moi, moins mystèrieuse je suis. Sauras-tu me percer à jour ?",
    lat: 48.8454382,
    lon: 2.2668038
  }, {
    birthdate: Date.new(1996, 10, 2),
    pseudo: "Mabelleenfait",
    first_name: "Michelle",
    last_name: "Mabelle",
    email: "michellemabelle@gmail.com",
    password: "michellemabelle@gmail.com",
    password_confirmation: "michellemabelle@gmail.com",
    address: "47 boulevard de Vaugirard, 75015, Paris",
    picture: "michelle.jpg",
    admin: "true",
    bio: "Sans aucun complexe, je suis une femme qui aime la vie et les plaisirs qu'elle offre.",
    lat: 48.8454382,
    lon: 2.2668038
  } , {
    birthdate: Date.new(1988, 4, 4),
    pseudo: "Bella",
    first_name: "Isabelle",
    last_name: "Alinord",
    email: "isabellealinord@gmail.com",
    password: "isabellealinord@gmail.com",
    password_confirmation: "isabellealinord@gmail.com",
    address: "67 Rue Nationale, 75013 Paris",
    picture: "isabelle.jpg",
    admin: "true",
    bio: "J'adore les sorties entre amis et les soirées à thème, alors...où va-t-on ?!",
    lat: 48.8260565,
    lon: 2.3661341
  }, {
    birthdate: Date.new(2000, 7, 7),
    pseudo: "Zoella",
    first_name: "Zoé",
    last_name: "Menu",
    email: "zoemenu@gmail.com",
    password: "zoemenu@gmail.com",
    password_confirmation: "zoemenu@gmail.com",
    address: "25 Rue Jean Giraudoux, 75017, Paris",
    picture: "zoe.jpg",
    admin: "true",
    bio: "Je m'inspire de ma mère, qui est une femme forte et indépendante. J'espère un jour lui ressembler.",
    lat: 48.8454382,
    lon: 2.2668038
  }, {
    birthdate: Date.new(1996, 10, 18),
    pseudo: "Cécédu75",
    first_name: "Céline",
    last_name: "Fort",
    email: "celinefort@gmail.com",
    password: "celinefort@gmail.com",
    password_confirmation: "celinefort@gmail.com",
    address: "7 rue Tardieu, 75018, Paris",
    picture: "celine.jpg",
    admin: "true",
    bio: "Je suis modèle photo depuis peu. J'adore la nature et les balaldes dans les parcs.",
    lat: 48.8454382,
    lon: 2.2668038
  }, {
    birthdate: Date.new(1997, 11, 7),
    pseudo: "Carlota",
    first_name: "Carla",
    last_name: "Champion",
    email: "carlachampion@gmail.com",
    password: "carlachampion@gmail.com",
    password_confirmation: "carlachampion@gmail.com",
    address: "11 rue Piquet, 75019, Paris",
    picture: "carla.jpg",
    admin: "true",
    bio: "Si j'étais un animal, je serais un chat. J'aime la tranquilité et la douceur de vivre.",
    lat: 48.8454382,
    lon: 2.2668038
  }, {
    birthdate: Date.new(1994, 12, 5),
    pseudo: "Rachie",
    first_name: "Rachel",
    last_name: "Ducati",
    email: "rachelducati@gmail.com",
    password: "rachelducati@gmail.com",
    password_confirmation: "rachelducati@gmail.com",
    address: "35 rue Lafitte, 75009, Paris",
    picture: "rachel.jpg",
    admin: "true",
    bio: "Si tu lis ces lignes, c'est que tu es curieux. J'aime les gens curieux.",
    lat: 48.8454382,
    lon: 2.2668038
  }]
)
puts "Created : #{users.count} Users"

# Create accointances in bulk
accointances = Accointance.create!(
  [{
    follower: users[0], recipient: users[6], status: 'pending'
  }, {
    follower: users[0], recipient: users[3], status: 'accepted'
  }, {
    follower: users[0], recipient: users[2], status: 'accepted'
  }, {
    follower: users[0], recipient: users[10], status: 'accepted'
  }, {
    follower: users[0], recipient: users[11], status: 'accepted'
  }, {
    follower: users[1], recipient: users[2], status: 'accepted'
  }, {
    follower: users[1], recipient: users[3], status: 'pending'
  }, {
    follower: users[5], recipient: users[2], status: 'accepted'
  }, {
    follower: users[6], recipient: users[2], status: 'accepted'
  }, {
    follower: users[7], recipient: users[0], status: 'pending'
  }, {
    follower: users[8], recipient: users[0], status: 'pending'
  }, {
    follower: users[9], recipient: users[0], status: 'pending'
  }, {
    follower: users[13], recipient: users[0], status: 'pending'
  }, {
    follower: users[3], recipient: users[2], status: 'accepted'
  }]
)
puts "Created : #{accointances.count} Accointances"

# Parse locations coming from geojson files
# parsed_locations = parse_location_data
# puts 'Parsed locations are uploaded from JSON files !'
# puts "Locations number: #{parsed_locations.count}"

# Parse locations coming from our personal parsed json file
parsed_locations = read_our_json_file
puts 'Parsed locations are uploaded from our personal JSON file !'
print "#{parsed_locations.count} Locations with "
# Count locations by type
location_counts_by_type = parsed_locations.each_with_object(Hash.new(0)) do |location, counts|
  counts[location[:type]] += 1
end
# Print each count of locations by type
location_counts_by_type.each do |type, count|
  print "#{count} '#{type}', "
end
puts '.'

parsed_locations.map { |location| location[:type] }.uniq.each do |type|
  VenueCategory.find_or_create_by(main_category: type, sub_category: "")
end
# Explicitly add 'Surprise' category
VenueCategory.find_or_create_by(main_category: 'Surprise', sub_category: "")

puts "Created : #{VenueCategory.count} VenueCategories"

puts 'Locations Bulk inserting in DB...'
# Prepare data for bulk insertion to speed-up the seeding
location_data = parsed_locations.map do |location|
  {
    location_type: location[:type],
    name: location[:name],
    address: "#{location[:street_number]}, #{location[:street_name]}",
    zip_code: location[:zip_code],
    city: location[:city],
    price_range: '€€',
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
puts "Created : #{LocationCategory.count} Location Categories"

# Find the 'Surprise' VenueCategory
default_venue_category = VenueCategory.find_by(main_category: 'Surprise', sub_category: "")

# Create meets in bulk
Accointance.all.each do |a|
  meet = Meet.create!(
    accointance_id: a.id,
    centered_address_long: -123.45678,
    centered_address_lat: 12.345678,
    status: a.status,
    date: Date.today + rand(1..30).days
  )

  # Associate Meet with a VenueCategory !
  MeetVenueCategory.create!(
    meet_id: meet.id,
    venue_category_id: default_venue_category.id
  )
  # Create a SelectedPlace for each Meet with status 'accepted'
  if meet.status == 'accepted'
    SelectedPlace.create!(
      meet_id: meet.id,
      location_id: Location.all.sample.id,
      selected_by_follower: true,
      selected_by_recipient: true
    )
  end
end
puts "Created : #{Meet.count} Meetings"
puts "Created : #{SelectedPlace.count} SelectedPlaces for Meetings"

categories = VenueCategory.all
users.each do |user|
  if user.first_name == 'Isabelle'
    # Manually set categories for Isabelle
    selected_categories = VenueCategory.where(main_category: ['Glacier', 'Jardin'])
  else
    # Determine a random number of preferences for other users (between 1 and 3)
    num_preferences = rand(1..3)
    # Shuffle categories and take the first num_preferences to ensure category uniqueness
    selected_categories = categories.shuffle.first(num_preferences)
  end

  selected_categories.each do |category|
    level = 1
    # Create the venue preference
    VenuePreference.create!(
      user_id: user.id,
      venue_category_id: category.id,
      preference_level: level
    )
  end
end
puts "Created : #{VenuePreference.count} User Preferences"

# That's it !
puts "Database seeded successfully!"
