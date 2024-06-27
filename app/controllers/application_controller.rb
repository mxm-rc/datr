class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def my_puts(message)
    puts "\e[32m**** #{message} ****\e[0m"
  end
end
