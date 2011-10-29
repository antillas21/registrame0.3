require 'spec_helper'

describe InterestsController do

  def valid_attributes
    {:name => 'Test Interest'}
  end

  describe "GET index" do
    it "assigns all interests as @interests" do
      interest = Interest.create! valid_attributes
      get :index
      assigns(:interests).should eq([interest])
    end
  end

  describe "GET show" do
    it "assigns the requested interest as @interest" do
      interest = Interest.create! valid_attributes
      get :show, :id => interest.id
      assigns(:interest).should eq(interest)
    end
  end

  describe "GET new" do
    it "assigns a new interest as @interest" do
      get :new
      # assigns(:interest).should be_a_new(Interest)
      assigns(:interest).class.should == Interest
    end
  end

  describe "GET edit" do
    it "assigns the requested interest as @interest" do
      interest = Interest.create! valid_attributes
      get :edit, :id => interest.id
      assigns(:interest).should eq(interest)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new interest" do
        expect {
          post :create, :interest => valid_attributes
        }.to change(Interest, :count).by(1)
      end

      it "assigns a newly created interest as @interest" do
        post :create, :interest => valid_attributes
        assigns(:interest).should be_a(Interest)
        assigns(:interest).should be_persisted
      end

      it "redirects to the created interest" do
        post :create, :interest => valid_attributes
        # response.should redirect_to(Interest.last)
        response.should redirect_to(interests_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved interest as @interest" do
        # Trigger the behavior that occurs when invalid params are submitted
        Interest.any_instance.stubs(:save).returns(false)
        post :create, :interest => {}
        # assigns(:interest).should be_a_new(Interest)
        assigns(:interest).class.should == Interest
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Interest.any_instance.stubs(:save).returns(false)
        post :create, :interest => {}
        response.should render_template("new")
      end
    end
  end
end
