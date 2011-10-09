require 'spec_helper'

describe Attendee do
  context '#validations' do
    it "should have a first name" do
      @attendee = Attendee.new(:email => 'homer@springfield.com', :last_name => 'Simpson')
      @attendee.valid?.should == false
    end
    
    it "should have a last name" do
      @attendee = Attendee.new(:email => 'homer@springfield.com', :first_name => 'Homer')
      @attendee.valid?.should == false
    end
    
    it "has a full name" do
      @attendee = Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com'
      )
      @attendee.full_name.should == 'Homer Simpson'
    end
    
    it "should have an email address" do
      @attendee = Attendee.new(:first_name => 'Homer', :last_name => 'Simpson')
      @attendee.valid?.should == false
    end
    
    it "should have a valid email address" do
      @homer = Attendee.new(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com'
      )
      @moe = Attendee.new(
        :first_name => 'Moe', :last_name => 'Zyslak', :email => 'moe!springfield.com'
      )
      @homer.valid?.should == true
      @moe.valid?.should == false
    end
    
    it "should have a unique email address" do
      @homer = Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com'
      )
      @barney = Attendee.new(
        :first_name => 'Barney', :last_name => 'Gumble', :email => 'homer@springfield.com'
      )
      @barney.valid?.should == false
    end
    
    it "may have a phone number" do
      @attendee = Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com',
        :phone => '9091112222'
      )
      @attendee.valid?.should == true
    end
    
    it "accepts only numbers in phone number field" do
      @homer = Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com',
        :phone => '9091112222'
      )
      @barney = Attendee.new(
        :first_name => 'Barney', :last_name => 'Gumble', :email => 'barney@springfield.com',
        :phone => '909-111-2222'
      )
      @moe = Attendee.new(
        :first_name => 'Moe', :last_name => 'Zyslack', :email => 'moe@springfield.com',
        :phone => '780-CALL-MOE'
      )
      
      @homer.valid?.should == true
      @barney.valid?.should == false
      @moe.valid?.should == false
    end    
  end
end
