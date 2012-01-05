class StatesController < ApplicationController
  respond_to :json

  def index
    @states = State.all(:name.like => "%#{params[:term]}%", order: [:name.asc])
    respond_with @states.map(&:name)
  end

end
