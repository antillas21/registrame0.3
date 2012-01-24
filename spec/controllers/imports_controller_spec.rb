require 'spec_helper'

describe ImportsController do
  def valid_attributes
    {
      document: File.join(Rails.root, 'spec', 'files', 'valid-import.csv'),
      document_file_name: 'valid-import.csv',
      document_content_type: 'text/csv'
    }
  end
  describe 'GET index' do
    it "assigns the last import as @imports" do
      import = Import.create! valid_attributes
      get :index
      assigns(:imports).should eq(import)
    end
  end

  describe "GET new" do
    it "assigns a new import as @import" do
      get :new
      assigns(:import).class.should == Import
    end
  end

  describe "GET show" do
    it "assigns the requested import as @import" do
      import = Import.create! valid_attributes
      get :show, :id => import.id
      assigns(:import).should eq(import)
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested import" do
      import = Import.create! valid_attributes
      expect {
        delete :destroy, :id => import.id
      }.to change(Import, :count).by(-1)
    end

    it "redirects to the imports list" do
      import = Import.create! valid_attributes
      delete :destroy, :id => import.id
      response.should redirect_to(imports_url)
    end
  end

  describe "POST import" do
    before do
      @imported = Import.create(:document => File.join(Rails.root, 'spec', 'files', 'valid-import.csv'),
                               :document_file_name => 'valid-import.csv', :document_content_type => 'text/csv')
    end

    it "is active from the #show page" do
      get :show, :id => @imported.id
      assigns(:import).should == @imported
    end

    it "fetches the attached csv file" do
      get :show, :id => @imported.id
      post :import, :id => @imported.id
#      assigns(:import_file).should eq(import.document.path)
      assigns(:import_file).present?.should be_true
    end

    it "imports all records found on csv file" do
      import = Import.create! valid_attributes
      post :import, :id => import.id

      Attendee.count.should == 6
    end

    it "counts Attendee records prior to import" do
      import = Import.create! valid_attributes
      count = Attendee.count

      post :import, :id => import.id
      assigns(:previous_count).should eq(count)
    end

    it "returns count for Imported records after process"

    it "destroys attached file after import process completes"
  end
end
