class PreferencesController < ApplicationController
  def show
    @preferences = Preference.first
  end

  def edit
    @preferences = Preference.first
  end

  def update
    @preferences = Preference.first
    if @preferences.update(params[:preference])
      redirect_to preference_path(@preferences), notice: 'Preferences successfully updated.'
    else
      render :edit, error: 'There was an error trying to save preferences, please try again.'
    end
  end
end
