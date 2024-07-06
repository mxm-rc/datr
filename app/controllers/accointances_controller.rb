class AccointancesController < ApplicationController
  # before_action :set_users, only: [:index]

  def index
    if params[:query].present?
      sql_query ="first_name ILIKE :query OR last_name ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.where.not(id: current_user.id).sort_by do |user|
        accointance = current_user.accointance_with(user)
        if accointance.nil?
          0
        else
          case accointance.status
          when 'accepted'
            1
          when 'pending'
            2
          when 'refused'
            3
          else
            4
          end
        end
      end
    end
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
