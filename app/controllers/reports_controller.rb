require 'munger'

class ReportsController < ApplicationController
  def index
    @total_records = Attendee.count
    attendees_per_status

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

  def show
    export_csv
  end

  def export_csv
    attendee_report
    @csv = CSV.generate do |csv|
      @att_collection.each do |row|
        csv << row
      end
    end

    created_at = Time.now.strftime("%Y%m%e-%H%M%S")
    send_data @csv, type: 'text/plain', filename: "attendee-report-#{created_at}.csv", disposition: 'attachment'
  end

  def attendee_report
    @attendees = Attendee.all
    @att_collection = [
      ['Registration Type', 'Full Name', 'Email', 'Phone', 'Company', 'Address', 'City', 'State', 'Country', 'Attended']
    ]
    @attendees.each do |attendee|
      @att_collection << [
          attendee.registration.to_s, attendee.full_name, attendee.email, attendee.phone, attendee.company_name.to_s,
          attendee.address, attendee.city, attendee.state_name.to_s, attendee.country_name.to_s, attendee.printed.to_s
        ]
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

  def attendees_per_status
    results = Attendee.aggregate(:printed, :all.count)
    q = []

    results.each do |row|
      q << {'Printed' => row[0].to_s, 'Total' => row[1]}
    end

    report = Munger::Report.from_data(q).sort('Printed').process
    @status_report = Munger::Render.to_html(report)
  end
end
