class StatesController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!

  def index
    @states = State.all(:name.like => "%#{params[:term]}%", order: [:name.asc])
    respond_with @states.map(&:name)
  end

end
