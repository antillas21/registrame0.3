class AttendeeTypesController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_user!

  before_filter :find_attendee_type, only: [:show, :edit, :update, :destroy]
  
  def index
    @attendee_types = AttendeeType.all
    @attendee_type = AttendeeType.new
  end

  def show

  end

  def new
    @attendee_type = AttendeeType.new
  end

  def create
    @attendee_type = AttendeeType.new(params[:attendee_type])
    if @attendee_type.save
      redirect_to attendee_types_path, notice: 'Attendee Type successfully created.'
    else
      render :new, error: 'Please correct any errors present.'
    end
  end

  def edit

  end

  def update
    if @attendee_type.update(params[:attendee_type])
      redirect_to attendee_types_path, notice: 'Attendee Type successfully updated'
    else
      render :edit, error: 'Please check any errors present.'
    end
  end

  def destroy
    @attendee_type.destroy
    redirect_to attendee_types_path, notice: 'Attendee Type successfully deleted'
  end

  private
  def find_attendee_type
    @attendee_type = AttendeeType.get(params[:id].to_i)
  end
end
