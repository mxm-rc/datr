class SelectedPlaceController < ApplicationController
  before_action :set_meet, only: [:index]

  def index
    # Logique pour générer la liste des lieux proposés en fonction des préférences du meeting
    limit = params[:limit].present? ? params[:limit].to_i : 3
    @places = generate_places(@meet, limit)
  end

  private

  def set_meet
    @meet = Meet.find(params[:meet_id])
  end

  def generate_places(meet, limit)
    # Filtre les places par type basées sur les préférences du meeting, les trie de manière aléatoire et applique la limite
    Location.where(type: meet.location_type).order("RANDOM()").limit(limit)
  end
end
