require 'json'
require_relative '../app/models/location'

@data_file_path = "db/seed_geojson/parsed_locations.json"

def read_our_json_file
  serialized_file = File.read(@data_file_path)
  JSON.parse(serialized_file, symbolize_names: true)
end

def parse_location_data
  allotment_filepath = "db/seed_geojson/allotments.geojson"
  serialized_allotments = File.read(allotment_filepath)
  allotments = JSON.parse(serialized_allotments)

  cinemas_filepath = "db/seed_geojson/cinemas.geojson"
  serialized_cinemas = File.read(cinemas_filepath)
  cinemas = JSON.parse(serialized_cinemas)

  historics_filepath = "db/seed_geojson/historics.geojson"
  serialized_historics = File.read(historics_filepath)
  historics = JSON.parse(serialized_historics)

  restaurants_filepath = "db/seed_geojson/restaurants.geojson"
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
      type: "garden",
      name: allotment["properties"]["name"],
      coordinates: {
        long: allotment["geometry"]["coordinates"][0],
        lat: allotment["geometry"]["coordinates"][1]
      }
    }
  end

  parsed_cinemas = cinemas["features"].map do |cinema|
    {
      type: "movies",
      name: cinema["properties"]["name"],
      website: cinema["properties"]["website"],
      phone: cinema["properties"]["phone"],
      coordinates: {
        long: cinema["geometry"]["coordinates"][0],
        lat: cinema["geometry"]["coordinates"][1]
      }
    }
  end

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
      "aircraft" => "Monument",
      "archaeological_site" => "Monument",
      "bar" => "Bar",
      "battlefield" => "Monument",
      "building" => "Monument",
      "cafe" => "Cafe",
      "castle" => "Chateau",
      "chapel" => "Chateau",
      "church" => "Chateau",
      "cinema" => "Cinema",
      "city_gate" => "Monument",
      "citywalls" => "Monument",
      "crime_scene" => "Monument",
      "fast food" => "Restauration rapide",
      "fountain" => "Monument",
      "food court" => "Restauration rapide",
      "garden" => "Jardin",
      "highwater_mark" => "Monument",
      "house" => "Restaurant",
      "ice cream" => "Glacier",
      "jardin" => "Jardin",
      "manor" => "Chateau",
      "mansion" => "Chateau",
      "memorial" => "Monument",
      "milestone" => "Monument",
      "monastery" => "Chateau",
      "monument" => "Monument",
      "movies" => "Cinema",
      "optical_telegraph" => "Monument",
      "palace" => "Chateau",
      "place_of_worship" => "Monument",
      "pub" => "Bar",
      "restaurant" => "Restaurant",
      "river_mark" => "Monument",
      "ruins" => "Chateau",
      "shieling" => "Jardin",
      "ship" => "Monument",
      "statue" => "Monument",
      "tower" => "Monument",
      "tomb" => "Monument",
      "tree" => "Jardin",
      "wall" => "Monument",
      "wayside_cross" => "Monument",
      "wayside_shrine" => "Monument",
      "yes" => "Restaurant"
    }
  # Initialize a hash with default value '0' to count occurrences of each category
  category_counts = Hash.new(0)

  # Remove locations with "name": null
  parsed_locations.reject! { |location| location[:name].nil? }

  # Access allowed_types from the Location model
  allowed_types = Location.allowed_types

  parsed_locations.map! do |location|
    mapped_type = type_mapping[location[:type]] || "Surprise" # Default to "surprise" if no mapping found
    location[:type] = mapped_type

    # Assign the picture based on the mapped category
    location[:picture] = allowed_types[mapped_type]

    # Increment the count for the mapped category
    category_counts[mapped_type] += 1

    # Return the updated location to the map method to replace original element in parsed_result
    location
  end

  # "Jardin"=>44, "Cinema"=>89, "Monument"=>1630, "Chateau"=>76, "Restaurant"=>8351, "Cafe"=>2102,
  # "Bar"=>2084, "Restauration rapide"=>2558, "Glacier"=>92
  # puts "Category counts: #{category_counts}"

  # Store the final result in a JSON file
  File.write(@data_file_path, JSON.pretty_generate(parsed_locations))

  parsed_locations
end
