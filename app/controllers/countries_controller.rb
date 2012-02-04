class CountriesController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!

  def index
    @countries = Country.all(:name.like => "%#{params[:term]}%", order: [:name.asc])
    respond_with @countries.map(&:name)
  end
end
