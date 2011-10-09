require 'spec_helper'

describe Company do
  context "#validations" do
    it "should have a name to be valid" do
      @company = Company.new(:address => '742 Evergreen Terrace', :city => 'Springfield')
      @company.valid?.should == false
    end
    
    it "should have a city to be valid" do
      @company = Company.new(:name => 'Homer Internet Co.')
      @company.valid?.should == false
    end
  end
  
  context "#formatted output" do
    it "has a nice url in the app" do
      @company = Company.create(:name => 'Homer Internet Co.', :city => 'Springfield')
      @other_company = Company.create(:name => 'Kwikie Mart', :city => 'Springfield')
      @another_company = Company.create(:name => 'Lewis Jr. and Sons', :city => 'Springfield')
      
      @company.to_param.should == "#{@company.id}-homer-internet-co"
      @other_company.to_param.should == "#{@other_company.id}-kwikie-mart"
      @another_company.to_param.should == "#{@another_company.id}-lewis-jr-and-sons"
    end
    
    it "displays a business card type record" do
      pending
    end
  end
end
