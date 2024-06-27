class MeetsController < ApplicationController
  before_action :set_friend, only: %i[new create]
  before_action :set_user, :set_meets, only: %i[index]

  def new
    @meet = Meet.new
    @location_types = Location.allowed_types{0}
    @meet_date = @meet.date
  end

  def create
    @accointance = Accointance.find_by(follower: [current_user.id, @friend.id], recipient: [current_user.id, @friend.id])
    @meet = @accointance.meets.new(meet_params)
    if @meet.save
      redirect_to friend_meet_selected_places_path(@friend, @meet), notice: 'Meet was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
    # meet"=>{"date"=>"2024-06-04", "venue_category_ids"=>["", "9"]},
  end

  def index
    my_puts("MeetsControlle#index: @meets = #{@meets.inspect} // @user = #{@user.inspect}")
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_meets
    # Find all accointance_ids where the user is either follower or recipient
    accointance_ids = Accointance.where("follower_id = ? OR recipient_id = ?", params[:user_id], params[:user_id]).pluck(:id)

    # Find all meets related to these accointances
    @meets = Meet.where(accointance_id: accointance_ids)
  end

  def set_friend
    @friend = User.find(params[:friend_id])
  end

  def meet_params
    params.require(:meet).permit(:date, venue_category_ids: [])
  end
end
