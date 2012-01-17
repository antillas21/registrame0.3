class PagesController < ApplicationController
  respond_to :json
  before_filter :set_badge_cookies, :only => [:index]
  before_filter :set_format_cookies, :only => [:index]

  def index
    @msg = 'Welcome to registrame'
  end

  def companies_autocomplete
    @companies = Company.all(:name.like => "%#{params[:term]}%", order: [:name.asc])
    respond_with @companies.map(&:name)
  end
end
