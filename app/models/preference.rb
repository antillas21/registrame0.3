class Preference

  include DataMapper::Resource

  property :id, Serial
  property :print_label, Boolean, default: true
  property :create_qrcode, Boolean, default: false

  property :label_field_fullname, Boolean, default: true
  property :label_field_email, Boolean, default: false
  property :label_field_phone, Boolean, default: false
  property :label_field_address, Boolean, default: false
  property :label_field_city, Boolean, default: false
  property :label_field_company, Boolean, default: true
  property :label_field_attendee_type, Boolean, default: true

  property :qrcode_field_fullname, Boolean, default: true
  property :qrcode_field_email, Boolean, default: true
  property :qrcode_field_phone, Boolean, default: true
  property :qrcode_field_address, Boolean, default: false
  property :qrcode_field_city, Boolean, default: false
  property :qrcode_field_company, Boolean, default: true

end
