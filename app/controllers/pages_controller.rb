class PagesController < ApplicationController
  respond_to :json

  def index
    @msg = 'Welcome to registrame'
  end

  def companies_autocomplete
    @companies = Company.all(:name.like => "%#{params[:term]}%", order: [:name.asc])
    respond_with @companies.map(&:name)
  end

end
