require 'spec_helper'

describe Country do
  it "has a name to be valid" do
    @us = Country.new()
    @mx = Country.new(:name => 'Mexico')
    
    @us.valid?.should == false
    @mx.valid?.should == true
  end
  
  it "has 0 to many attendees" do
    @us = Country.create(:name => 'Ohio')
    @mx = Country.create(:name => 'Arizona')
    
    10.times do |index|
      Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => "email-#{index}@example.com",
        :phone => '9091112222', :address => '247 Evergreen Terrace', :city => 'Springfield',
        :country => @us
      )
    end
    
    @us.attendees.count.should == 10
    @mx.attendees.count.should == 0
  end
  
end
