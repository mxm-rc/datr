class MeetsController < ApplicationController
  before_action :set_friend

  def new
    @meet = Meet.new
    @location_types = Location.allowed_types{0}
  end

  def create
    @meet = @friend.meets.new(meet_params)
    if @meet.save
      redirect_to friend_meet_selected_places_path(@friend, @meet), notice: 'Meet was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
  #   @meets = Meet.find(params[:user_id]) #TO DO
  end

  private

  def set_friend
    @friend = User.find(params[:friend_id])
  end

  def meet_params
    params.require(:meet).permit(:date, :location_type)
  end
end
