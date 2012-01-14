class PagesController < ApplicationController
  respond_to :json
  before_filter :set_badge_cookies

  def index
    @msg = 'Welcome to registrame'
    if session[:current_user].present?
      @this_user = session[:current_user].user
    end
  end

  def companies_autocomplete
    @companies = Company.all(:name.like => "%#{params[:term]}%", order: [:name.asc])
    respond_with @companies.map(&:name)
  end
end
