class SelectedPlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meet, :set_friend, only: %i[index new create]
  before_action :set_limit, :set_midpoint, only: %i[index]

  def index
    # Fetch the recommended Locations according to the common Categories between the current user and the friend
    @places = Location.recommended_locations(current_user, @friend, @mid_point, @limit)

    # Insert mid_point_location at first in places
    @places.unshift(@mid_point)
    # Debug places in rails server console
    # Rails.logger.debug "Places: #{@places.inspect}"

    # Prepare markers for the Map_Box api
    @markers = @places.present? ? generate_markers(@places) : []
  end

  def create
    place_ids = params[:selected_places] || []
    # Places user has chosen
    @places = Location.find(place_ids)

    @places.each do |place|
      SelectedPlace.create(set_place(@meet, place))
    end

    # Debug selected places in rails server console
    @selected_places = SelectedPlace.where(meet: @meet)
    puts @selected_places.inspect

    redirect_to date_summary_path, notice: 'Création des lieux sélectionnés avec succès !'
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
      # lat: @meet.centered_address_lat,  Not calculated yet
      # lon: @meet.centered_address_long  Not calculated yet
      #
      # Eiffel Tower latitude, longitude
      lat: 48.8583,
      lon: 2.2944
    )
  end

  def set_place(meet, place)
    selected_place = SelectedPlace.new

    selected_place.meet = meet
    selected_place.location = place
    selected_place.selected_by_follower = true
    selected_place.selected_by_recipient = false

    return selected_place
  end

  # Prepare markers for the Map_Box api
  def generate_markers(places)
    places.map do |place|
      {
        lat: place.lat,
        lng: place.lon,
        info_window_html: render_to_string(partial: "info_window", locals: { place: place })
      }
    end
  end
end
