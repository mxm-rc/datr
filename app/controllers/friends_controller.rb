class FriendsController < ApplicationController
  before_action :set_friend, only: [:show]

  def index
    @accointances = Accointance.where(follower: current_user).or(Accointance.where(recipient: current_user))
    @friends = @accointances.map do |accointance|
      accointance.friend_of(current_user)
    end.uniq
  end

  def show
  end

  private

  def set_friend
    @friend = User.find(params[:id])
  end
end
