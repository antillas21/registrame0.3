require 'spec_helper'

describe AttendeeTypesController do

  def valid_attributes
    {:name => 'Visitor'}
  end

  describe "GET index" do
    it "assigns all attendee_types as @attendee_types" do
      attendee_type = AttendeeType.create! valid_attributes
      get :index
      assigns(:attendee_types).should eq([attendee_type])
    end
  end

  describe "GET show" do
    it "assigns the requested attendee_type as @attendee_type" do
      attendee_type = AttendeeType.create! valid_attributes
      get :show, :id => attendee_type.id
      assigns(:attendee_type).should eq(attendee_type)
    end
  end

  describe "GET new" do
    it "assigns a new attendee_type as @attendee_type" do
      get :new
      # assigns(:attendee_type).should be_a_new(attendee_type)
      assigns(:attendee_type).class.should == AttendeeType
    end
  end

  describe "GET edit" do
    it "assigns the requested attendee_type as @attendee_type" do
      attendee_type = AttendeeType.create! valid_attributes
      get :edit, :id => attendee_type.id
      assigns(:attendee_type).should eq(attendee_type)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested company" do
        attendee_type = AttendeeType.create! valid_attributes
        # Assuming there are no other companies in the database, this
        # specifies that the attendee_type created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        AttendeeType.any_instance.expects(:update).with({'name' => 'New Name'})
        put :update, :id => attendee_type.id, :attendee_type => {'name' => 'New Name'}
      end

      it "assigns the requested attendee_type as @attendee_type" do
        attendee_type = AttendeeType.create! valid_attributes
        put :update, :id => attendee_type.id, :attendee_type => valid_attributes
        assigns(:attendee_type).should eq(attendee_type)
      end

      it "redirects to the attendee_types index" do
        attendee_type = AttendeeType.create! valid_attributes
        put :update, :id => attendee_type.id, :attendee_type => valid_attributes
        response.should redirect_to(attendee_types_path)
      end
    end

    describe "with invalid params" do
      it "assigns the attendee_type as @attendee_type" do
        attendee_type = AttendeeType.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AttendeeType.any_instance.stubs(:save).returns(false)
        put :update, :id => attendee_type.id, :attendee_type => {}
        assigns(:attendee_type).should eq(attendee_type)
      end

      it "re-renders the 'edit' template" do
        attendee_type = AttendeeType.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AttendeeType.any_instance.stubs(:save).returns(false)
        put :update, :id => attendee_type.id, :attendee_type => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested attendee_type" do
      attendee_type = AttendeeType.create! valid_attributes
      expect {
        delete :destroy, :id => attendee_type.id
      }.to change(AttendeeType, :count).by(-1)
    end

    it "redirects to the attendee_types list" do
      attendee_type = AttendeeType.create! valid_attributes
      delete :destroy, :id => attendee_type.id
      response.should redirect_to(attendee_types_url)
    end
  end
end
