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
    label_defaults = {"full_name" => "1", "company" => "1", "attendee_type" => "1"}
    prefs = Preference.create
    prefs.label_options.should == label_defaults
  end

  it "sends the following fields to QRCode by default: Full name, Email, Phone, Company Name" do
    qrcode_defaults = {"full_name" => "1", "email" => "1", "phone" => "1", "company" => "1"}
    prefs = Preference.create
    prefs.qrcode_options.should == qrcode_defaults
  end

end
