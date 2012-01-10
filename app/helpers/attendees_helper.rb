module AttendeesHelper

  def address_data(attendee)
    str = []
    [attendee.address, attendee.city, attendee.state_name, attendee.country_name].each do |attr|
      str << attr unless attr.blank?
    end
    return str.join(', ')
  end

  def email_phone(attendee)
    str = []
    [attendee.email, number_to_phone(attendee.phone, area_code: true)].each do |attr|
      str << attr unless attr.blank?
    end
    return str.join(' | ')
  end
end
