class SelectedPlacesController < ApplicationController
  before_action :set_meet, :set_friend, only: [:index]

  def index
    # Soit limit est défini dans les paramètres, soit il vaut 3 par défaut
    limit = params[:limit].present? ? params[:limit].to_i : 3

    # Critères sous forme de liste dans un tableau ['Restaurant', 'Bar', 'Cinéma']
    criteria = ['Restaurant']

    @places = generate_places(criteria, limit)
    @markers = @places.map do |place|
      {
        lat: place.lat,
        lng: place.lon,
        info_window_html: render_to_string(partial: "info_window", locals: { place: place })
      }
    end
  end

  private

  def set_meet
    @meet = Meet.find(params[:meet_id])
  end

  def set_friend
    @friend = User.find(params[:friend_id])
  end

  def generate_places(criteria, limit)
    # Filtre les places d'après criteria et applique la limite
    Location.where('location_type ILIKE ANY (ARRAY[?])', criteria).limit(limit)
  end
end
