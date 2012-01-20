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
end
