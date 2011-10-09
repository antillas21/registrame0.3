require 'spec_helper'

describe User do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "validations" do
    it "must contain an email address" do
      @user = User.new(
          :login => 'Homer Simpson', :password => 'password', :password_confirmation => 'password'
        )
      
      @user.valid?.should == false
    end
    
    it "must contain a valid email address" do
      @user = User.new(
        :login => 'Homer Simpson', :email => 'homer!springfield.com', :password => 'password',
        :password_confirmation => 'password'
      )
      @other_user = User.new(
        :login => 'Homer Simpson', :email => 'homer@springfieldcom', :password => 'password',
        :password_confirmation => 'password'
      )
      
      @user.valid?.should == false
      @other_user.valid?.should == false
    end
    
    it "must contain a login name" do
      @user = User.new(
        :email => 'homer@springfield.com', :password => 'password',
        :password_confirmation => 'password'
      )
      
      @user.valid?.should == false
    end
  end
end
