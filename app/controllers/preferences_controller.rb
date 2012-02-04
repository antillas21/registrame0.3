class PreferencesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :fetch_label_and_qrcode_options, :only => [:show, :edit]

  def show
  end

  def edit
  end

  def update
    @preferences = Preference.first
    if @preferences.update(params[:preference])
      redirect_to preference_path(@preferences), notice: 'Preferences successfully updated.'
      set_badge_cookies
    else
      render :edit, error: 'There was an error trying to save preferences, please try again.'
    end
  end

  private
  def fetch_label_and_qrcode_options
    @preferences = Preference.first
    @label_options = @preferences.label_options
    @qrcode_options = @preferences.qrcode_options
  end
end
