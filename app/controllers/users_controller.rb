class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit]

  def show
  end

  def edit
    puts @user.inspect
  end

  private

  # Find the current user based on the user_id parameter
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # Handle exceptions, e.g., redirect to a 404 page or show an error message
    redirect_to(root_url, alert: "Utilisateur introuvable !")
  end
end
