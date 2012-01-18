require 'spec_helper'

describe PdfDocument do
  describe "attributes" do
    it "has a widht and height according to cookies values" do
      cookies = {}
      cookies[:label_format] = [4.0, 3.0]

      pdf = PdfDocument.new(cookies[:label_format], cookies[:label_margins], cookies[:font_size])
      pdf.width.should == 4.0
      pdf.height.should == 3.0
    end

    it "has a set of margins according to cookies values" do
      cookies = {}
      cookies[:label_margins] = [1,2,3,4]

      pdf = PdfDocument.new(cookies[:label_format], cookies[:label_margins], cookies[:font_size])
      pdf.top.should == 1
      pdf.left.should == 2
      pdf.right.should == 3
      pdf.bottom.should == 4
    end

    it "has a font size according to cookies values" do
      cookies = {}
      cookies[:font_size] = 16
      pdf = PdfDocument.new(cookies[:label_format], cookies[:label_margins], cookies[:font_size])
      pdf.font_size.should == 16
    end
  end

  describe "#create" do
    before do
      @cookies ={
        label_format: [4.0, 3.0], label_margins: [0.25, 0.25, 0.25, 0.25], font_size: 14
      }
      @doc = PdfDocument.new(@cookies[:label_format], @cookies[:label_margins], @cookies[:font_size])
      @attendee = Attendee.create!(
        first_name: "John", last_name: "Doe", email: "john@example.com", company_name: "Bigshot Company"
      )
    end

    it "instantiates a new Prawn::Document object"

    context "with only text data" do
      it "populates PDF document with Attendee data" do
        @label_contents = ["full_name", "company_name"]
        @pdf = @doc.create_label(@attendee, false, @label_contents)

        created_pdf = PDF::Reader.new("#{Rails.root.to_s}/public/uploads/labels/#{@attendee.to_param}.pdf")
        page = created_pdf.pages.first
        page.text.split("\n").should == ["John Doe", "Bigshot Company"]
      end
    end

    context "with text and QRCode data" do
      it "populates PDF document with Attendee data and QRCode" do
        @label_contents = ["full_name", "company_name"]
        @qrcode_contents = ["full_name", "email", "company_name"]

        @pdf = @doc.create_label(@attendee, true, @label_contents)

        created_pdf = PDF::Reader.new("#{Rails.root.to_s}/public/uploads/labels/#{@attendee.to_param}.pdf")
        expected_pdf = PDF::Reader.new("#{Rails.root.to_s}/spec/files/text-and-qrcode.pdf")

        page = created_pdf.pages.first
        page.text.split("\n").should == ["John Doe", "Bigshot Company"]

        created_pdf.should == expected_pdf
      end
    end

    it "creates a PDF file at /public/uploads/labels directory" do
      @pdf = @doc.create_label(@attendee)
      File.exists?("#{Rails.root.to_s}/public/uploads/labels/#{@attendee.to_param}.pdf").should be_true
    end
  end
end
