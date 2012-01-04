require 'spec_helper'

describe CompaniesController do

  def valid_attributes
    {:name => 'Bigshot Company Inc.'}
  end

  describe "GET index" do
    it "assigns all companies as @companies"
#      company = Company.create! valid_attributes
#      get :index
#      assigns(:companies).should eq([company])

    it "renders a JSON file to use on index.html with datatables" do
      get :index, format: :json
      response.should be_success
      
      json_body = JSON.parse(response.body)
      json_body.should include('sEcho')
      json_body.should include('aaData')
    end
  end

  describe "GET show" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :show, :id => company.id
      assigns(:company).should eq(company)
    end
  end

#  describe "GET new" do
#    it "assigns a new interest as @interest" do
#      get :new
#      # assigns(:interest).should be_a_new(Interest)
#      assigns(:interest).class.should == Interest
#    end
#  end

  describe "GET edit" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :edit, :id => company.id
      assigns(:company).should eq(company)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested company" do
        company = Company.create! valid_attributes
        # Assuming there are no other companies in the database, this
        # specifies that the Company created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Company.any_instance.expects(:update).with({'name' => 'New Name'})
        put :update, :id => company.id, :company => {'name' => 'New Name'}
      end

      it "assigns the requested company as @company" do
        company = Company.create! valid_attributes
        put :update, :id => company.id, :company => valid_attributes
        assigns(:company).should eq(company)
      end

      it "redirects to the company" do
        company = Company.create! valid_attributes
        put :update, :id => company.id, :company => valid_attributes
        response.should redirect_to(company)
      end
    end

    describe "with invalid params" do
      it "assigns the company as @company" do
        company = Company.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Company.any_instance.stubs(:save).returns(false)
        put :update, :id => company.id, :company => {}
        assigns(:company).should eq(company)
      end

      it "re-renders the 'edit' template" do
        company = Company.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Company.any_instance.stubs(:save).returns(false)
        put :update, :id => company.id, :company => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested company" do
      company = Company.create! valid_attributes
      expect {
        delete :destroy, :id => company.id
      }.to change(Company, :count).by(-1)
    end

    it "redirects to the companies list" do
      company = Company.create! valid_attributes
      delete :destroy, :id => company.id
      response.should redirect_to(companies_url)
    end
  end
end
