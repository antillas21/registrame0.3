class PagesController < ApplicationController
  respond_to :json
  before_filter :set_badge_cookies, :only => [:index]
  before_filter :set_format_cookies, :only => [:index]
  before_filter :authenticate_user!, :except => [:index]

  def index
    @msg = 'Welcome to registrame'

    if AttendeeType.count > 0
      @registration_types = AttendeeType.all

      @registration_data = []
      @registration_types.each do |registration|
        @registration_data << {registration_name: registration.name, attendee_count: registration.attendees.count}
      end
    end
  end

  def statistics
  end

  def companies_autocomplete
    @companies = Company.all(:name.like => "%#{params[:term]}%", order: [:name.asc])
    respond_with @companies.map(&:name)
  end
end
