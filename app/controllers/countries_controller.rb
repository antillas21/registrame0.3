class CountriesController < ApplicationController
  respond_to :json

  def index
    @countries = Country.all(:name.like => "%#{params[:term]}%", order: [:name.asc])
    respond_with @countries.map(&:name)
  end
end
