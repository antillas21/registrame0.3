require 'munger'

class PagesController < ApplicationController
  respond_to :json
  before_filter :set_badge_cookies, :only => [:index]
  before_filter :set_format_cookies, :only => [:index]
  before_filter :authenticate_user!, :except => [:index]

  def index
    @msg = 'Welcome to registrame'
  end

  def statistics
    if State.count > 0
      attendees_per_state
    end
    if Country.count > 0
      attendees_per_country
    end
  end

  def companies_autocomplete
    @companies = Company.all(:name.like => "%#{params[:term]}%", order: [:name.asc])
    respond_with @companies.map(&:name)
  end

  def attendees_per_state
    @states = State.all
    q = []
    @states.each do |state|
    h = {"State" => state.name}
      if AttendeeType.count > 0
      @at = AttendeeType.all
        @at.each do |type|
        thash = {}
        thash["#{type.name}"] = Attendee.count(:attendee_type => type, :state => state)

        h.merge!(thash) if thash.present?
        end
      end
    q << h
    end

    report = Munger::Report.from_data(q).sort('State').process
    @state_report = Munger::Render.to_html(report)
  end

  def attendees_per_country
    @countries = Country.all
    q = []
    @countries.each do |country|
    h = {"Country" => country.name}
      if AttendeeType.count > 0
      @at = AttendeeType.all
        @at.each do |type|
        thash = {}
        thash["#{type.name}"] = Attendee.count(:attendee_type => type, :country => country)

        h.merge!(thash) if thash.present?
        end
      end
    q << h
    end

    report = Munger::Report.from_data(q).sort('Country').process
    @country_report = Munger::Render.to_html(report)
  end
end
