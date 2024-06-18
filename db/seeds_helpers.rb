require 'json'

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
      type: "Garden",
      name: allotment["properties"]["name"],
      coordinates: {
        long: allotment["geometry"]["coordinates"][0],
        lat: allotment["geometry"]["coordinates"][1]
      }
    }
  end

  parsed_cinemas = cinemas["features"].map do |cinema|
    {
      type: "Movies",
      name: cinema["properties"]["name"],
      website: cinema["properties"]["website"],
      phone: cinema["properties"]["phone"],
      coordinates: {
        long: cinema["geometry"]["coordinates"][0],
        lat: cinema["geometry"]["coordinates"][1]
      }
    }
  end

  [parsed_allotments, parsed_cinemas, parsed_historics, parsed_restaurants].flatten
end
