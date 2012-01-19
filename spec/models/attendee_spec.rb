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
    
    it "may have a mailing address" do
      @homer = Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com',
        :phone => '9091112222', :address => '247 Evergreen Terrace'
      )
      @homer.valid?.should == true
      @homer.address.should == '247 Evergreen Terrace'
    end
    
    it "may have a city to live" do
      @homer = Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com',
        :phone => '9091112222', :city => 'Springfield'
      )
      @homer.valid?.should == true
      @homer.city.should == 'Springfield'
    end
  end
  
  context "States" do
    before do
      @oh = State.create(:name => 'Ohio')
      @homer = Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com',
        :phone => '9091112222', :city => 'Springfield', :state => @oh
      )
      @moe = Attendee.create(
        :first_name => 'Moe', :last_name => 'Zyslack', :email => 'moe@springfield.com',
        :phone => '9091112222', :city => 'Springfield'
      )
    end
    
    it "may belong to a state" do
      @homer.state.present?.should == true
      @homer.state.name.should == 'Ohio'
      
      @moe.state.present?.should == false
      @moe.state.should == nil
    end

    it "delegates :state_name to State.name" do
      @homer.state_name.should == 'Ohio'
    end

    it "creates a new State record when no :state_name is found" do
      attendee = Attendee.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', state_name: 'California')
      attendee.state_name.should == 'California'
      State.first(name: 'California').should_not be_nil
    end
  end
    
  context "Countries" do
    before do
      @us = Country.create(:name => 'United States')
      @homer = Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com',
        :phone => '9091112222', :city => 'Springfield', :country => @us
      )
      @moe = Attendee.create(
        :first_name => 'Moe', :last_name => 'Zyslack', :email => 'moe@springfield.com',
        :phone => '9091112222', :city => 'Springfield'
      )
    end
    
    it "may belong to a country" do
      @homer.country.present?.should == true
      @homer.country.name.should == 'United States'
      
      @moe.country.present?.should == false
      @moe.country.should == nil
    end

    it "delegates :country_name to Country.name" do
      @homer.country_name.should == 'United States'
    end

    it "creates a new Country record when no :country_name is found" do
      attendee = Attendee.create(first_name: 'Louis', last_name: 'Clark', email: 'louis@exmaple.com', country_name: 'Canada')
      attendee.country_name.should == 'Canada'
      Country.first(name: 'Canada').should_not be_nil
    end
  end

  context "Companies" do
    it "delegates :company_name to Company.name attribute" do
      company = Company.create(name: 'BigShot Ltd.')
      attendee = Attendee.create(first_name: 'John', last_name: 'Doe', email: 'john@exmaple.com', company: company)
      attendee.company_name.should == company.name
    end

    it "creates a Company record when no :company_name is found" do
      attendee = Attendee.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', company_name: 'X Games')
      attendee.company_name.should == 'X Games'
      Company.first(name: 'X Games').should_not be_nil
    end
  end
  
  context "#formatted output" do
    before do
      @homer = Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com',
        :phone => '9091112222', :city => 'Springfield'
      )
      
      @jfk = Attendee.create(
        :first_name => 'John F.', :last_name => 'Kennedy', :email => 'homer@springfield.com',
        :phone => '9091112222', :city => 'Springfield'
      )
    end
      
      it "has a nice formatted url in the app" do
        @homer.to_param.should == "#{@homer.id}-homer-simpson"
        @jfk.to_param.should == "#{@jfk.id}-john-f-kennedy"
      end
  end
  
  context "Relationships" do
    before do
      @meet = Interest.create(:name => 'Meet')
      @greet = Interest.create(:name => 'Greet')
    end
    
    it "may have 0 or several interests" do
      @homer = Attendee.create(
        :first_name => 'Homer', :last_name => 'Simpson', :email => 'homer@springfield.com',
        :phone => '9091112222', :city => 'Springfield', :interests => [@meet, @greet]
      )
      
      @jfk = Attendee.create(
        :first_name => 'John F.', :last_name => 'Kennedy', :email => 'homer@springfield.com',
        :phone => '9091112222', :city => 'Springfield'
      )
      
      @homer.interests.should include(@meet)
      @homer.interests.should include(@greet)
      @jfk.interests.count.should == 0
    end
  end

  describe "Printed namebadges" do
    before do
      [["Homer", "homer@springfield.com"], ["Marge", "marge@springfield.com"], ["Bart", "bart@springfield.com"]].each do |name, email|
        Attendee.create(
          first_name: name, last_name: "Simpson", email: email
        )
      end
    end

    it "keeps track of attendees that have generated their namebadge" do
      Attendee.count.should == 3
      Attendee.printed.should == []

      homer = Attendee.first(first_name: "Homer")
      marge = Attendee.first(first_name: "Marge")
      homer.update(printed: true)

      Attendee.printed.should include(homer)
      Attendee.printed.should_not include(marge)
    end

    it "calculates total printed namebadges" do
      Attendee.printed_badges.should == 0

      Attendee.first.update(printed: true)
      Attendee.last.update(printed: true)

      Attendee.printed_badges.should == 2
    end
  end
  
end
