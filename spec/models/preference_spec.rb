require 'spec_helper'

describe Preference do
  it "defaults to print NameBadge labels" do
    prefs = Preference.create
    prefs.print_label.should == true
  end

  it "defaults to not create QRCodes" do
    prefs = Preference.create
    prefs.create_qrcode.should == false
  end

  it "sends the folowing fields to NameBadge label by default: Full name, Company name, Attendee type" do
    prefs = Preference.create
    [:label_field_fullname, :label_field_company, :label_field_attendee_type].each do |attr|
      prefs.attribute_get(attr).should == true
    end
  end

  it "sends the following fields to QRCode by default: Full name, Email, Phone, Company Name" do
    prefs = Preference.create
    [:qrcode_field_fullname, :qrcode_field_email, :qrcode_field_phone, :qrcode_field_company].each do |attr|
      prefs.attribute_get(attr).should == true
    end
  end

end
