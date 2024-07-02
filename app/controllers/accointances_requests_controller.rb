class AccointancesRequestsController < ApplicationController
  def index
    @accointances = Accointance.where(status: 'pending', recipient_id: current_user.id)
  end

  def update
    accointance = Accointance.find(params[:id])
    accointance.status = params[:status]
    redirect_to accointances_requests_path, notice: 'Success' if accointance.save
  end
end
