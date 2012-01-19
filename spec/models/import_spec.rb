require 'spec_helper'

describe Import do
  describe ".create" do
    it "should contain a file attachment" do
      @bad_import = Import.new
      @bad_import.valid?.should be_false
      @bad_import.errors.should include(["Document must be set"])
    end

    it "validates attachment is a .csv file" do
      @bad_import = Import.new(:document => "#{Rails.root}/spec/files/text-and-qrcode.pdf")
      @bad_import.valid?.should be_false
      @bad_import.errors.should include([""])
    end
  end
end
