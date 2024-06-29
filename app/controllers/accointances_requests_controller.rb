class AccointancesRequestsController < ApplicationController

  def index
    @accointances = Accointance.where(status: 'pending', follower_id: current_user.id)
  end

  def approve
    accointance = Accointance.find(params[:id])
    accointance.update(status: 'accepted')

    redirect_to accointances_requests_path, notice: 'Success'
  end

  def deny
    accointance = Accointance.find(params[:id])
    accointance.update(status: 'refused')

    redirect_to accointances_requests_path, notice: 'Success'
  end
end
