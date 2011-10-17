require 'spec_helper'

describe State do
  it "has a name to be valid" do
    @state = State.new()
    @state.valid?.should == false
    
    @other_state = State.new(:name => 'Ohio')
    @other_state.valid?.should == true
  end
  
  it "has 0 to many attendees" do
    @oh = State.create(:name => 'Ohio')
    @az = State.create(:name => 'Arizona')
    
    10.times do |index|
      Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => "email-#{index}@example.com",
        :phone => '9091112222', :address => '247 Evergreen Terrace', :city => 'Springfield',
        :state => @oh
      )
    end
    
    @oh.attendees.count.should == 10
    @az.attendees.count.should == 0
  end
end
