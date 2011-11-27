class PreferencesController < ApplicationController
  def show
    @preferences = Preference.first
  end

  def edit
    @preferences = Preference.first
  end

  def update
    @preferences = Preference.first
    if @preferences.update(params[:preferences])
      redirect_to @preferences, notice: 'Preferences successfully updated.'
    else
      render :edit, error: 'There was an error trying to save preferences, please try again.'
    end
  end
end
