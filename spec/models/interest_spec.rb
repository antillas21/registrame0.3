require 'spec_helper'

describe Interest do
  context "#validations" do
    it "should have a name" do
      @interest = Interest.new
      
      @interest.valid?.should == false
    end
    
    it "should have a unique name" do
      @interest = Interest.create(:name => 'Meet')
      @meet = Interest.new(:name => 'Meet')
      
      @meet.valid?.should == false
    end
  end
  
  context "Relationships" do
    before do
      @meet = Interest.create(:name => 'Meet')
      @greet = Interest.create(:name => 'Greet')
    end
    
    it "can have 0 Attendees" do
      @meet.attendees.count.should == 0
    end
    
    it "may have several Attendees" do
      [
        {:first_name => 'Fred', :last_name => 'Flintstone', :email => 'fred@bedrock.com'},
        {:first_name => 'Barney', :last_name => 'Rubble', :email => 'barney@bedrock.com'}
      ].each do |attendee|
        Attendee.create(
          :first_name => attendee[:first_name], :last_name => attendee[:last_name],
          :email => attendee[:email], :interests => [@meet]
        )
      end
      
      @meet.attendees.count.should == 2
      @fred = Attendee.first(:first_name => 'Fred')
      @fred.interests.should include(@meet)
    end
  end
end
