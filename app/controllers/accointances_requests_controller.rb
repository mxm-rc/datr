class AccointancesRequestsController < ApplicationController

  def index
    @accointances = Accointance.where(recipient: current_user)
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