require 'spec_helper'

describe AttendeesController do

  def valid_attributes
    {first_name: 'John', last_name: 'Doe', email: 'john@example.com'}
  end

  describe "GET index" do
#    it "assigns all attendees as @attendees" do
#      attendee = Attendee.create! valid_attributes
#      get :index
#      assigns(:attendees).should eq([attendee])
#    end
    it "renders a customized JSON file" do
      get :index, format: :json
      response.should be_success
      body = JSON.parse(response.body)
      body.should include("sEcho")
      body.should include("aaData")
    end
  end

  describe "GET show" do
    it "assigns the requested attendee as @attendee" do
      attendee = Attendee.create! valid_attributes
      get :show, :id => attendee.id
      assigns(:attendee).should eq(attendee)
    end

    it "marks an attendee as printed once its namebadge is generated" do
      john = Attendee.create! valid_attributes
      get :show, :id => john.id
      get :namebadge, :id => john.id
      john.printed.should be_true
    end
  end

  describe "GET new" do
    it "assigns a new attendee as @attendee" do
      get :new
      # assigns(:attendee).should be_a_new(attendee)
      assigns(:attendee).class.should == Attendee
    end
  end

  describe "GET edit" do
    it "assigns the requested attendee as @attendee" do
      attendee = Attendee.create! valid_attributes
      get :edit, :id => attendee.id
      assigns(:attendee).should eq(attendee)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested attendee" do
        attendee = Attendee.create! valid_attributes
        # Assuming there are no other attendees in the database, this
        # specifies that the attendee created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Attendee.any_instance.expects(:update).with({'first_name' => 'New Name'})
        put :update, :id => attendee.id, :attendee => {'first_name' => 'New Name'}
      end

      it "assigns the requested attendee as @attendee" do
        attendee = Attendee.create! valid_attributes
        put :update, :id => attendee.id, :attendee => valid_attributes
        assigns(:attendee).should eq(attendee)
      end

      it "redirects to the attendee" do
        attendee = Attendee.create! valid_attributes
        put :update, :id => attendee.id, :attendee => valid_attributes
        response.should redirect_to(attendee)
      end
    end

    describe "with invalid params" do
      it "assigns the attendee as @attendee" do
        attendee = Attendee.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Attendee.any_instance.stubs(:save).returns(false)
        put :update, :id => attendee.id, :attendee => {}
        assigns(:attendee).should eq(attendee)
      end

      it "re-renders the 'edit' template" do
        attendee = Attendee.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Attendee.any_instance.stubs(:save).returns(false)
        put :update, :id => attendee.id, :attendee => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested attendee" do
      attendee = Attendee.create! valid_attributes
      expect {
        delete :destroy, :id => attendee.id
      }.to change(Attendee, :count).by(-1)
    end

    it "redirects to the attendees list" do
      attendee = Attendee.create! valid_attributes
      delete :destroy, :id => attendee.id
      response.should redirect_to(attendees_url)
    end
  end
end
