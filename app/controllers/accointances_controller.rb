class AccointancesController < ApplicationController
  # before_action :set_users, only: [:index]

  def index
    @users = User.all
    @accointances = User.all
  end

  def create
    @accointance = Accointance.new
    @accointance.recipient = User.find(params[:user_id])
    @accointance.follower = current_user
    if @accointance.save
      redirect_to accointances_path, notice: 'Accointance was successfully created.'
    else
      redirect_to accointances_path, alert: 'There was an error creating the accointance.'
    end
  end
end
