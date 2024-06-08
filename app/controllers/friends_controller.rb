class FriendsController < ApplicationController
  before_action :set_friend, only: [:show]

  def index
    @accointances = policy_scope(Accointance)
    @friends = @accointances.map do |accointance|
      accointance.friend_of(current_user)
    end
  end

  def show
    authorize @friend, policy_class: FriendPolicy
  end

  private

  def set_friend
    @friend = User.find(params[:id])
  end
end
