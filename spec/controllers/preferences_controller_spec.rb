require 'spec_helper'

describe PreferencesController do

  def valid_attributes
    {:create_qrcode => false}
  end

  describe "GET show" do
    it "assigns the requested preference as @preference" do
      preferences = Preference.create! 
      get :show, :id => preferences.id
      assigns(:preferences).should eq(preferences)
    end
  end

  describe "GET edit" do
    it "assigns the requested preference as @preference" do
      preferences = Preference.create! 
      get :edit, :id => preferences.id
      assigns(:preferences).should eq(preferences)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested preference" do
        preferences = Preference.create! 
        Preference.any_instance.expects(:update).with({ 'create_qrcode' => true})
        put :update, id: preferences.id, preference: { create_qrcode: true } 
      end

      it "assigns the requested preference as @preference" do
        preferences = Preference.create! 
        put :update, :id => preferences.id, :preference => valid_attributes
        assigns(:preferences).should eq(preferences)
      end

      it "redirects to the preference" do
        preferences = Preference.create! 
        put :update, :id => preferences.id, :preference => valid_attributes
        response.should redirect_to(preferences)
      end
    end
  end

end
