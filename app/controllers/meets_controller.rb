class MeetsController < ApplicationController
  before_action :set_friend

  def new
    @meet = Meet.new
  end

  def create
    @meet = @friend.meets.new(meet_params)
    if @meet.save
      redirect_to friend_meet_selected_places_path(@friend, @meet), notice: 'Meet was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_friend
    @friend = Accointance.find(params[:friend_id])
  end

  def meet_params
    params.require(:meet).permit(:date, :location_type)
  end
end
