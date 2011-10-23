require 'spec_helper'

describe Label do
  context "Validations" do
    it "should have a name to be valid" do
      @label = Label.new(:width => 2, :height => 3, :font_size => 14)
      
      @label.valid?.should == false
      @label.errors.should include(["Name can't be blank"])
    end
    
    it "should have width and height to be valid" do
      @label = Label.new(:name => 'DYMO Std 2x4', :font_size => 14)
      
      @label.valid?.should == false
      @label.errors.should include(["Width can't be blank"])
      @label.errors.should include(["Height can't be blank"])
    end
    
    it "has a default font size value" do
      @label = Label.create(:name => 'DYMO Std 2x4', :width => 2, :height => 4)
      
      @label.font_size.should == 14
    end
    
    it "has default margins set upon creation" do
      @label = Label.create(:name => 'DYMO Std 2x4', :width => 2, :height => 4)
      
      @label.top.should == 0.125
      @label.bottom.should == 0.125
      @label.left.should == 0.125
      @label.right.should == 0.125
    end
  end
end
