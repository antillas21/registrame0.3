require 'spec_helper'

describe StatesController do

  def valid_attributes
    {:name => 'California'}
  end

  describe "GET index" do
    it "assigns all states as @states" do
      state = State.create! valid_attributes
      get :index
      assigns[:states].should eq([state])
    end

    it "responds to json format" do
      get :index, format: :json
      response.should be_success
    end
  end

end
