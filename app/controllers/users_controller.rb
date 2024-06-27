class UsersController < ApplicationController
  before_action :set_user, :set_preferences, only: %i[edit update show]
  before_action :set_selected_preferences, only: %i[update], if: -> { @user.present? }

  def show
  end

  def edit
    my_puts("Method user_controller.edit.@preferences (if empty, it will be filled with joker): #{@preferences.inspect}")

    # if @preferences is empty, fill preference by default
    @preferences = VenuePreference.set_default_preference if @preferences.empty?
    my_puts("Method user_controller.edit.@preferences: #{@preferences.inspect}")
  end

  def update
    my_puts("Method user_controller.update.@selected_Preferences : #{@selected_preferences}")

    # Begin a transaction block to remove/create categories (rollback if any issue)
    ActiveRecord::Base.transaction do
      # Get current preference types
      current_preferences = @user.venue_preferences.map { |vp| vp.venue_category.main_category }
      my_puts("Method user_controller.update.current_preferences from DB (before update): #{current_preferences}")

      remove_preferences(current_preferences)

      add_preferences(current_preferences)
    end

    # Print all user's preferences from DB
    current_preferences = @user.venue_preferences.map { |vp| vp.venue_category.main_category }
    my_puts("Method user_controller.update current_preferences (after update): #{current_preferences}")

    redirect_to friends_path, notice: 'Preferences updated successfully!'

  rescue ActiveRecord::RecordInvalid => e
    my_puts("Error: #{e.message}")

    # Handle any errors, e.g., rollback and show an error message
    flash[:alert] = 'Erreur dans la mise à jour des préférences.'
    render :edit
  end

  private

  def remove_preferences(current_preferences)
    # Add to preferences_to remove similar preferences in current_preferences and @selected_preferences
    preferences_to_remove = current_preferences - @selected_preferences

    if preferences_to_remove.empty?
      my_puts("Method user_controller.update.preferences_to_remove (nothing to destroy): #{preferences_to_remove.inspect}")
    else
      my_puts("Method user_controller.update.preferences_to_remove (to be destroyed): #{preferences_to_remove.inspect}")

      # Remove from DB preferences that are existing in current_preferences but not in @selected_preferences
      preferences_to_remove.each do |preference|
        category = VenueCategory.find_by(main_category: preference)
        @user.venue_preferences.where(venue_category: category).destroy_all if category
      end
    end
  end

  def add_preferences(current_preferences)
    # Determine new preferences to add (in @selected_preferences but not in current_preferences)
    preferences_to_add = @selected_preferences - current_preferences

    if preferences_to_add.empty?
      my_puts("Method user_controller.update.preferences_to_add (nothing to create): #{preferences_to_add.inspect}")
    else
      my_puts("Method user_controller.update.preferences_to_add (to be created): #{preferences_to_add.inspect}")

      # Create in DB preferences that are existing in @selected_preferences but not in current_preferences
      preferences_to_add.each do |preference|
        category = VenueCategory.find_by(main_category: preference)
        @user.venue_preferences.create!(venue_category: category) if category
      end
    end
  end

  # Find the current user based on the user_id parameter
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def set_preferences
    @preferences = @user.venue_preferences.includes(:venue_category)
                        .map { |vp| vp.venue_category.main_category }.uniq
  rescue ActiveRecord::RecordNotFound
    # Handle exceptions, e.g., redirect to a 404 page or show an error message
    redirect_to(friends_url, alert: "Preferences introuvables !")
  end

  def set_selected_preferences
    # Assuming `params[:preferences]` contains an array of selected preference types
    my_puts("Method user_controller.set_selected_preferences.@user_params: #{user_params[:preferences]}")
    preferences = user_params[:preferences] || []

    # Get the keys (location types) from Location.allowed_types as an array
    allowed_types = Location.allowed_types.keys

    @selected_preferences = preferences.select { |preference| allowed_types.include?(preference) }
  end

  def user_params
    params.require(:user).permit(:other_attributes, preferences: []).tap do |permitted|
      permitted[:preferences] = params[:user][:preferences] if params[:user][:preferences].is_a?(Array)
    end
    end
end
