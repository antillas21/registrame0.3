require 'spec_helper'

describe Import do
  describe ".create" do
    it "should contain a file attachment" do
      @bad_import = Import.new
      @bad_import.valid?.should be_false
      @bad_import.errors.should include(["Document must be set"])
    end

    it "validates attachment is a .csv file" do
      @bad_import = Import.create(
        document: File.join(Rails.root, 'spec', 'files', 'text-and-qrcode.pdf'),
        document_file_name: 'text-and-qrcode.pdf', document_content_type: 'application/pdf'
      )
      @bad_import.valid?.should be_false
      @bad_import.errors.should include(["Document's content type of 'application/pdf' is not a valid content type"])

      @good_import = Import.new(
        document: File.join(Rails.root, 'spec', 'files', 'valid-import.csv'),
        document_file_name: 'valid-import.csv', document_content_type: 'text/csv'
      )
      @good_import.valid?.should be_true
    end

  end
end
