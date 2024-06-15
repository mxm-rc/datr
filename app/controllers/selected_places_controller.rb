class SelectedPlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meet, :set_friend, :set_limit, only: [:index]

  # Method trop longue ?
  def index
    @places = Location.recommended_locations(current_user, @friend, limit)
    @markers = @places.present? ? generate_markers(@places) : []
  end

  private

  # Find the meet based on the meet_id parameter
  def set_meet
    # Ensure ID is integer to avoid SQL injection (basic validation)
    @meet = Meet.find(params[:meet_id]).to_i
  rescue ActiveRecord::RecordNotFound
    # Handle exceptions, e.g., redirect to a 404 page or show an error message
    redirect_to(root_url, alert: "Meet introuvable !")
  end

  # Find the friend based on the friend_id parameter
  def set_friend
    # Ensure ID is integer to avoid SQL injection (basic validation)
    @friend = User.find(params[:friend_id]).to_i
  rescue ActiveRecord::RecordNotFound
    # Handle exceptions, e.g., redirect to a 404 page or show an error message
    redirect_to(root_url, alert: "Ami introuvable !")
  end

  # Validate the limit parameter
  def set_limit
    # Ensure limit is integer and between 1 and 6
    @limit = params[:limit].to_i.clamp(1, 6)
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
