require 'spec_helper'

describe LabelsController do

  def valid_attributes
    {name: 'DYMO Default', width: 4.0, height: 2.125}
  end

  describe "GET index" do
    it "assigns all labels as @labels" do
      label = Label.create! valid_attributes
      get :index
      assigns(:labels).should eq([label])
    end
  end

  describe "GET show" do
    it "assigns the requested label as @label" do
      label = Label.create! valid_attributes
      get :show, :id => label.id
      assigns(:label).should eq(label)
    end
  end

  describe "GET new" do
    it "assigns a new label as @label" do
      get :new
      # assigns(:label).should be_a_new(label)
      assigns(:label).class.should == Label
    end
  end

  describe "GET edit" do
    it "assigns the requested label as @label" do
      label = Label.create! valid_attributes
      get :edit, :id => label.id
      assigns(:label).should eq(label)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested label" do
        label = Label.create! valid_attributes
        # Assuming there are no other companies in the database, this
        # specifies that the label created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Label.any_instance.expects(:update).with({'name' => 'New Name'})
        put :update, :id => label.id, :label => {'name' => 'New Name'}
      end

      it "assigns the requested label as @label" do
        label = Label.create! valid_attributes
        put :update, :id => label.id, :label => valid_attributes
        assigns(:label).should eq(label)
      end

      it "redirects to the @label" do
        label = Label.create! valid_attributes
        put :update, :id => label.id, :label => valid_attributes
        response.should redirect_to(label)
      end
    end

    describe "with invalid params" do
      it "assigns the label as @label" do
        label = Label.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Label.any_instance.stubs(:save).returns(false)
        put :update, :id => label.id, :label => {}
        assigns(:label).should eq(label)
      end

      it "re-renders the 'edit' template" do
        label = Label.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Label.any_instance.stubs(:save).returns(false)
        put :update, :id => label.id, :label => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested label" do
      label = Label.create! valid_attributes
      expect {
        delete :destroy, :id => label.id
      }.to change(Label, :count).by(-1)
    end

    it "redirects to the labels list" do
      label = Label.create! valid_attributes
      delete :destroy, :id => label.id
      response.should redirect_to(labels_url)
    end
  end
end
