class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home landing_page]

  def landing_page
  end
end
