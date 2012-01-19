class Preference

  include DataMapper::Resource

  property :id, Serial
  property :print_label, Boolean, default: true
  property :create_qrcode, Boolean, default: false

  property :label_options, Json, :default => {"full_name" => "1", "company_name" => "1", "registration_type" => "1"}
  property :qrcode_options, Json, :default => {"full_name" => "1", "email" => "1", "phone" => "1", "company_name" => "1"}
end
