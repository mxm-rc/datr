class AccointancesController < ApplicationController
  # before_action :set_users, only: [:index]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def create
    recipient = User.find(params[:user_id])
    @accointance = Accointance.new(follower: current_user, recipient: recipient, status: "pending")

    if @accointance.save
      redirect_to accointances_path, notice: 'Accointance was successfully created.'
    else
      redirect_to accointances_path, alert: 'There was an error creating the accointance.'
    end
  end
end
