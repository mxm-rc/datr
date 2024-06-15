class FriendsController < ApplicationController
  before_action :set_friend, only: [:show]

  def index
    @friends = current_user.friends(status: 'accepted')

    if params[:query].present?
      @friends = @friends.where("first_name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
  end

  private

  def set_friend
    @friend = User.find(params[:id])
  end
end
