require 'spec_helper'

describe Company do
  context "#validations" do
    it "should have a name to be valid" do
      @company = Company.new()
      @company.valid?.should == false
    end  
  end
  
  context "#formatted output" do
    it "has a nice url in the app" do
      @company = Company.create(:name => 'Homer Internet Co.')
      @other_company = Company.create(:name => 'Kwikie Mart')
      @another_company = Company.create(:name => 'Lewis Jr. and Sons')
      
      @company.to_param.should == "#{@company.id}-homer-internet-co"
      @other_company.to_param.should == "#{@other_company.id}-kwikie-mart"
      @another_company.to_param.should == "#{@another_company.id}-lewis-jr-and-sons"
    end    
  end
end
