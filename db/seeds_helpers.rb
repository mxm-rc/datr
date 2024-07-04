require 'json'
require 'faker'
require 'geocoder'
require_relative '../app/models/location'

Faker::Config.locale = 'fr'
@data_file_path = 'db/seed_geojson/parsed_locations.json'

# Configure Geocoder with custom HTTP headers
Geocoder.configure(
  http_headers: { 'User-Agent' => 'School Project: Halfway/0.5 (cmacom1@efree.fr)' }
)

def read_our_json_file
  serialized_file = File.read(@data_file_path)
  JSON.parse(serialized_file, symbolize_names: true)
end

def parse_location_data
  allotment_filepath = 'db/seed_geojson/allotments.geojson'
  serialized_allotments = File.read(allotment_filepath)
  allotments = JSON.parse(serialized_allotments)

  cinemas_filepath = 'db/seed_geojson/cinemas.geojson'
  serialized_cinemas = File.read(cinemas_filepath)
  cinemas = JSON.parse(serialized_cinemas)

  historics_filepath = 'db/seed_geojson/historics.geojson'
  serialized_historics = File.read(historics_filepath)
  historics = JSON.parse(serialized_historics)

  restaurants_filepath = 'db/seed_geojson/restaurants.geojson'
  serialized_restaurants = File.read(restaurants_filepath)
  restaurants = JSON.parse(serialized_restaurants)
  zip_codes = ['75001', '75002', '75003', '75004', '75005', '75006', '75007', '75008', '75009', '75010',
               '75011', '75012', '75013', '75014', '75015', '75016', '75017', '75018', '75019', '75020']
  puts("Restaurants : #{restaurants['features'].count}")
  i = 0
  j = 1_000
  max = 15_333
  parsed_restaurants = restaurants['features'].drop(4_000).take(j).map do |restaurant|
    sleep(3)
    lat = restaurant['geometry']['coordinates'][1].round(7)
    lon = restaurant['geometry']['coordinates'][0].round(7)
    geocode_info = reverse_geocode(lat, lon)
    puts("Geocode info: #{i + 1}/#{j} #{geocode_info.inspect}")
    i += 1 if geocode_info
    {
      # OpenStreetMap key: amenaty value: bar, pub...
      # https://wiki.openstreetmap.org/wiki/Key:amenity
      osm_type: geocode_info['type'],
      type: restaurant['properties']['type'],
      name: geocode_info['name'] || restaurant['properties']['name'],
      street_number: geocode_info['street_number'] || Faker::Address.building_number,
      street_name: geocode_info[:street_name] || Faker::Address.street_name,
      block: geocode_info['block'] || '',
      suburb: geocode_info['suburb'] || '',
      city: geocode_info['city'] || 'Paris',
      zip_code: geocode_info['zip_code'] || zip_codes.sample,
      region: geocode_info['region'] || 'Île-de-France',
      coordinates: {
        long: lon,
        lat: lat
      }
    }
  end.compact
  puts("Number of restaurants: #{i}/#{j}")

  puts("Cinemas : #{cinemas['features'].count}")
  i = 0
  j = 0
  max = 89
  parsed_cinemas = cinemas["features"].drop(0).take(j).map do |cinema|
    sleep(3)
    lat = cinema['geometry']['coordinates'][1].round(7)
    lon = cinema['geometry']['coordinates'][0].round(7)
    geocode_info = reverse_geocode(lat, lon)
    puts("Geocode info: #{i + 1}/#{j} #{geocode_info.inspect}")
    i += 1 if geocode_info
    {
      osm_type: geocode_info['type'],
      type: 'movies',
      name: geocode_info['name'] || cinema['properties']['name'],
      street_number: geocode_info['street_number'] || Faker::Address.building_number,
      street_name: geocode_info[:street_name] || Faker::Address.street_name,
      block: geocode_info['block'] || '',
      suburb: geocode_info['suburb'] || '',
      city: geocode_info['city'] || 'Paris',
      zip_code: geocode_info['zip_code'] || zip_codes.sample,
      region: geocode_info['region'] || 'Île-de-France',
      coordinates: {
        long: lon,
        lat: lat
      }
    }
  end.compact
  puts("Number of Cinema: #{i}/#{j}")

  puts("Jardins : #{allotments['features'].count}")
  i = 0
  j = 0
  max = 55
  parsed_allotments = allotments['features'].drop(0).take(j).map do |allotment|
    sleep(3)
    lat = allotment['geometry']['coordinates'][1].round(7)
    lon = allotment['geometry']['coordinates'][0].round(7)
    geocode_info = reverse_geocode(lat, lon)
    puts("Geocode info: #{i + 1}/#{j}  #{geocode_info.inspect}")
    i += 1 if geocode_info
    {
      osm_type: geocode_info['type'],
      type: "garden",
      name: geocode_info['name'] || allotment['properties']['name'],
      street_number: geocode_info['street_number'] || Faker::Address.building_number,
      street_name: geocode_info[:street_name] || Faker::Address.street_name,
      block: geocode_info['block'] || '',
      suburb: geocode_info['suburb'] || '',
      city: geocode_info['city'] || 'Paris',
      zip_code: geocode_info['zip_code'] || zip_codes.sample,
      region: geocode_info['region'] || 'Île-de-France',
      coordinates: {
        long: lon,
        lat: lat
      }
    }
  end.compact
  puts("Number of Jardin: #{i}/#{j}")

  puts("Historic : #{historics['features'].count}")
  i = 0
  j = 0
  max = 2_725
  parsed_historics = historics['features'].drop(1_000).take(j).map do |historic|
    sleep(3)
    lat = historic['geometry']['coordinates'][1].round(7)
    lon = historic['geometry']['coordinates'][0].round(7)
    geocode_info = reverse_geocode(lat, lon)
    puts("Geocode info: #{i + 1}/#{j} #{geocode_info.inspect}")
    i += 1 if geocode_info
    {
      osm_type: geocode_info['type'],
      type: historic['properties']['type'],
      name: geocode_info['name'] || historic['properties']['name'],
      street_number: geocode_info['street_number'] || Faker::Address.building_number,
      street_name: geocode_info[:street_name] || Faker::Address.street_name,
      block: geocode_info['block'] || '',
      suburb: geocode_info['suburb'] || '',
      city: geocode_info['city'] || 'Paris',
      zip_code: geocode_info['zip_code'] || zip_codes.sample,
      region: geocode_info['region'] || 'Île-de-France',
      coordinates: {
        long: lon,
        lat: lat

      }
    }
  end.compact
  puts("Number of historics: #{i}/#{j}")

  build_new_seed([parsed_allotments, parsed_cinemas, parsed_historics, parsed_restaurants].flatten)
end

def build_new_seed(parsed_locations)
  # Extract unique types from parsed_locations
  # Unique_location_types: [
  # Jardin(55), Cinéma(89), fountain(291), memorial(1050), tomb(587), optical_telegraph(1), place_of_worship(394),
  # monastery(4), wayside_cross(6), yes(109), wayside_shrine(4), crime_scene(4), highwater_mark(10), house(2), tree(2),
  # archaeological_site(3), Monument(61), ruins(21), battlefield(2), milestone(2), castle(13), citywalls(1), building(83),
  # river_mark(3), cafe(2148), cannon(18), shieling(1), aircraft(1), manor(38), mansion(1), city_gate(2), tower(2),
  # chapel(1), palace(1), statue(2), church(2), ship(1), wall(1), Bar(1804), Restaurant(8369), pub(302), fast_food(2609),
  # ice_cream(93), food_court(9) ]
  #
  # Unique_location_types are from model location

  # Define the mapping based on keys from parsed_locations
  type_mapping =
    {
      'aircraft' => 'Monument',
      'archaeological_site' => 'Monument',
      'bar' => 'Bar',
      'battlefield' => 'Monument',
      'building' => 'Monument',
      'cafe' => 'Cafe',
      'castle' => 'Chateau',
      'chapel' => 'Chateau',
      'church' => 'Chateau',
      'cinema' => 'Cinema',
      'city_gate' => 'Monument',
      'citywalls' => 'Monument',
      'crime_scene' => 'Monument',
      'fast food' => 'Restauration rapide',
      'fountain' => 'Monument',
      'food court' => 'Restauration rapide',
      'garden' => 'Jardin',
      'highwater_mark' => 'Monument',
      'house' => 'Restaurant',
      'ice cream' => 'Glacier',
      'jardin' => 'Jardin',
      'manor' => 'Chateau',
      'mansion' => 'Chateau',
      'memorial' => 'Monument',
      'milestone' => 'Monument',
      'monastery' => 'Chateau',
      'monument' => 'Monument',
      'movies' => 'Cinema',
      'optical_telegraph' => 'Monument',
      'palace' => 'Chateau',
      'place_of_worship' => 'Monument',
      'pub' => 'Bar',
      'restaurant' => 'Restaurant',
      'river_mark' => 'Monument',
      'ruins' => 'Chateau',
      'shieling' => 'Jardin',
      'ship' => 'Monument',
      'statue' => 'Monument',
      'tower' => 'Monument',
      'tomb' => 'Monument',
      'tree' => 'Jardin',
      'wall' => 'Monument',
      'wayside_cross' => 'Monument',
      'wayside_shrine' => 'Monument',
      'yes' => 'Restaurant'
    }
  # Initialize a hash with default value '0' to count occurrences of each category
  category_counts = Hash.new(0)

  # Remove locations with 'name': null
  parsed_locations.reject! { |location| location[:name].nil? }

  # Access allowed_types from the Location model
  allowed_types = Location.allowed_types

  parsed_locations.map! do |location|
    mapped_type = type_mapping[location[:type]] || 'Surprise' # Default to 'surprise' if no mapping found
    location[:type] = mapped_type

    # Assign the picture based on the mapped category
    location[:picture] = allowed_types[mapped_type]

    # Increment the count for the mapped category
    category_counts[mapped_type] += 1

    # Return the updated location to the map method to replace original element in parsed_result
    location
  end

  # 'Jardin'=>44, 'Cinema'=>89, 'Monument'=>1630, 'Chateau'=>76, 'Restaurant'=>8351, 'Cafe'=>2102,
  # 'Bar'=>2084, 'Restauration rapide'=>2558, 'Glacier'=>92
  # puts 'Category counts: #{category_counts}'

  # Store the final result in a JSON file
  # File.write(@data_file_path, JSON.pretty_generate(parsed_locations))

  # Append the final result to a JSON file
  # File.open(@data_file_path, 'a') do |file|
  #   file.puts JSON.pretty_generate(parsed_locations)
  # end

  # Step 1: Read the existing data from the file
  existing_locations = []
  if File.exist?(@data_file_path)
    file_content = File.read(@data_file_path)
    existing_locations = JSON.parse(file_content) unless file_content.empty?
  end

  # Step 2: Append new parsed locations to the existing ones
  updated_locations = existing_locations + parsed_locations

  # Step 3: Write the updated locations back to the file
  # File.open(@data_file_path, 'w') do |file|
  #  file.puts JSON.pretty_generate(updated_locations)
  # end
  # Store the final result in a JSON file
  File.write(@data_file_path, JSON.pretty_generate(updated_locations))

  updated_locations
end

def reverse_geocode(lat, lon)
  # Use gem geocoder for reverse geocoding
  puts("Latitude : #{lat}, Longitude : #{lon}")
  results = Geocoder.search([lat, lon])
  if results
    first_result = results.first
    if first_result&.data&.dig('address')
      type = first_result.data['type']
      name = first_result.data['name']
      number = first_result.data['address']['house_number']
      street = first_result.data['address']['road']
      block = first_result.data['address']['block']
      suburb = first_result.data['address']['suburb']
      zip_code = first_result.data['address']['postcode']
      city = first_result.data['address']['city']
      state = first_result.data['address']['state']
      return { "type" => type,
               "name" => name,
               "street_number" => number,
               "street_name" => street,
               "block" => block,
               "suburb" => suburb,
               "city" => city,
               "zip_code" => zip_code,
               "region" => state
             }
    end
  end
  {}
end
