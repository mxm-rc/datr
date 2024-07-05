class SelectedPlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meet, :set_friend, only: %i[index show new create]
  before_action :set_limit, :set_midpoint, only: %i[index]

  def index
    # Get if exist the categories selected by the user
    prefs = VenueCategory.where(id: @meet.venue_category_ids)
    my_puts("SelectedControlle#Index: Prefs = #{prefs.inspect}")

    # Search recommended Locations according to the common Categories between the current user and the friend
    @places = Location.recommended_locations(current_user, @friend, @mid_point, @limit, prefs)
    my_puts("SelectedPlacesController.index MidPoint: #{@mid_point.inspect}")
    puts
    my_puts("SelectedPlacesController.index @places: #{@places.inspect}")

    # Insert mid_point_location at first in places
    @places.unshift(@mid_point)
    # Debug places in rails server console
    puts "Places avec MidPoint en 1er: #{@places.inspect}"

    # Prepare markers for the Map_Box api
    @markers = @places.present? ? generate_markers(@places) : []
  end

  def show
    puts "show"
    @selected_places = SelectedPlace.where(meet_id: @meet.id)
  end

  def create
    place_ids = params[:selected_places] || []
    # Places user has clicked on
    @places = Location.find(place_ids)

    @places.each do |place|
      SelectedPlace.create(set_place(@meet, place))
    end
    @selected_place = SelectedPlace.where(meet_id: @meet.id).first
    redirect_to friend_meet_selected_place_path(friend_id: @friend, meet_id: @meet, id: @selected_place), notice: 'Création des lieux sélectionnés avec succès !'
  end

  private

  # Find the meet based on the meet_id parameter
  def set_meet
    @meet = Meet.find(params[:meet_id])
  rescue ActiveRecord::RecordNotFound
    # Handle exceptions, e.g., redirect to a 404 page or show an error message
    redirect_to(root_url, alert: "Meet introuvable !")
  end

  # Find the friend based on the friend_id parameter
  def set_friend
    @friend = User.find(params[:friend_id])
  rescue ActiveRecord::RecordNotFound
    # Handle exceptions, e.g., redirect to a 404 page or show an error message
    redirect_to(root_url, alert: "Ami introuvable !")
  end

  # Validate the limit parameter
  def set_limit
    # Ensure limit is integer and between 1 and 6
    @limit = params[:limit].to_i.clamp(1, 6)
  end

  def set_midpoint
    @mid_point = Location.new(
      name: "Midpoint",
      lat: @meet.centered_address_lat,
      lon: @meet.centered_address_long
      #
      # Eiffel Tower latitude, longitude
      # lat: 48.8583,
      # lon: 2.2944
    )
  end

  def set_place(meet, place)
    {
      meet: meet,
      location: place,
      selected_by_follower: true,
      selected_by_recipient: false
    }
  end

  # Prepare markers for the Map_Box api
  def generate_markers(places)
    places.each_with_index.map do |place, index|
      {
        lat: place.lat,
        lng: place.lon,
        info_window_html: render_to_string(partial: "info_window", locals: { place: place, index: index })
      }
    end
  end
end
