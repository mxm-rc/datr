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
    @accointance.save # Will raise ActiveModel::ForbiddenAttributesError
    # redirect_to accointances_path
  end

  # def destroy
  #   @accointance = @accointance.find(params[:id])
  #   @accointance.destroy
  #   redirect_to accointances_path, status: :see_other
  # end

  private

  # def set_user
  # end

end
