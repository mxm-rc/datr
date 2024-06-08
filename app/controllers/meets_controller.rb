class MeetsController < ApplicationController

  def show
    @accointance = Accointance.find(params[:id])
  end
end
