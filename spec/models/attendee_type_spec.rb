require 'spec_helper'

describe AttendeeType do
  context '#validations' do
    it "must have a name" do
      @type = AttendeeType.new
      
      @type.valid?.should == false
    end
    
    it "must have a unique name" do
      @type = AttendeeType.create(:name => 'Visitor')
      @other = AttendeeType.new(:name => 'Visitor')
      
      @other.valid?.should == false
    end
  end
  
  context "Relationships" do
    before do
      @visitor = AttendeeType.create(:name => 'Visitor')
      @exhibitor = AttendeeType.create(:name => 'Exhibitor')
    end
    
    it "may have 0 or several Attendees" do
      [
        {:first_name => 'Fred', :last_name => 'Flintstone', :email => 'fred@bedrock.com'},
        {:first_name => 'Barney', :last_name => 'Rubble', :email => 'barney@bedrock.com'}
      ].each do |attendee|
        Attendee.create(
          :first_name => attendee[:first_name], :last_name => attendee[:last_name],
          :email => attendee[:email], :attendee_type => @visitor
        )
      end
      
      @visitor.attendees.count == 2
      @exhibitor.attendees.count == 0
    end
  end
end
