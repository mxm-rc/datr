class UsersController < ApplicationController
  before_action :set_user, :set_preferences, only: %i[edit update show]
  before_action :set_selected_preferences, only: %i[update], if: -> { @user.present? }

  def show
  end

  def edit
  end

  def update
    puts "**** update method : #{@selected_preferences}****"
    # Begin a transaction to ensure data integrity
    ActiveRecord::Base.transaction do
      # Get current preference types
      current_preferences = @user.venue_preferences.map { |vp| vp.venue_category.main_category }

      # Determine preferences to remove (not in @selected_preferences)
      preferences_to_remove = current_preferences - @selected_preferences
      preferences_to_remove.each do |preference_type|
        category = VenueCategory.find_by(main_category: preference_type)
        @user.venue_preferences.where(venue_category: category).destroy_all if category
      end

      # Determine new preferences to add (in @selected_preferences but not in current_preferences)
      preferences_to_add = @selected_preferences - current_preferences
      preferences_to_add.each do |preference_type|
        category = VenueCategory.find_by(main_category: preference_type)
        @user.venue_preferences.create!(venue_category: category) if category
      end
    end
    redirect_to root_path, notice: 'Preferences updated successfully!'
  rescue ActiveRecord::RecordInvalid => e
    puts "Error: #{e.message}"

    # Handle any errors, e.g., rollback and show an error message
    flash[:alert] = 'Erreur dans la mise à jour des préférences.'
    render :edit
  end

  private

  # Find the current user based on the user_id parameter
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def set_preferences
    @preferences = @user.venue_preferences.includes(:venue_category)
                        .map { |vp| vp.venue_category.main_category }.uniq
  rescue ActiveRecord::RecordNotFound
    # Handle exceptions, e.g., redirect to a 404 page or show an error message
    redirect_to(root_url, alert: "Preferences introuvables !")
  end

  def set_selected_preferences
    # Assuming `params[:preferences]` contains an array of selected preference types
    preferences = user_params[:preferences]&.values || []
    # Get the keys (location types) from Location.allowed_types as an array
    allowed_types_keys = Location.allowed_types.keys

    # Map "1" values to their corresponding location types
    @selected_preferences = preferences.each_with_index.map do |preference, index|
      allowed_types_keys[index] if preference == "1"
    end.compact # Remove nil values
  end

  def user_params
    params.require(:user).permit(:other_attributes, preferences: {}).tap do |permitted|
      permitted[:preferences] = params[:user][:preferences].permit! if params[:user][:preferences]
    end
  end
end
