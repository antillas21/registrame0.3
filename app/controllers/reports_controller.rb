require 'munger'

class ReportsController < ApplicationController
  def index
    @total_records = Attendee.count

    if State.count > 0
      attendees_per_state
    end
    if Country.count > 0
      attendees_per_country
    end
    if AttendeeType.count > 0
      attendees_per_attendee_type
    end
  end

  def attendees_per_attendee_type
    if AttendeeType.count > 0
      q = []
      @at = AttendeeType.all
      @at.each do |type|
        q << {'Attendee Type' => type.name, 'Total' => Attendee.count(:attendee_type => type)}
      end
    end

    report = Munger::Report.from_data(q).sort('Attendee Type').process
    @at_type_report = Munger::Render.to_html(report)
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
      else
        h.merge!({'Total' => Attendee.count(:state => state)})
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
      else
        h.merge!({'Total' => Attendee.count(:country => country)})
      end
    q << h
    end

    report = Munger::Report.from_data(q).sort('Country').process
    @country_report = Munger::Render.to_html(report)
  end
end
