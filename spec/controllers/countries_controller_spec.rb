require 'spec_helper'

describe CountriesController do

  def valid_attributes
    {:name => 'United States'}
  end

  describe "GET index" do
    it "assigns all countries as @countries" do
      country = Country.create! valid_attributes
      get :index
      assigns[:countries].should eq([country])
    end
  end
end
