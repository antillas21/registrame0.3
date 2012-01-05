class AttendeesController < ApplicationController
  before_filter :get_attendee, only: [:show, :edit, :update, :destroy]

  def index
    @attendees = Attendee.all
  end

  def show
  end

  def new
    @attendee = Attendee.new
    @attendee_types = AttendeeType.all(order: [:name.asc])
  end

  def create
    @attendee = Attendee.new(params[:attendee])
    if @attendee.save
      redirect_to attendee_path(@attendee), notice: 'Attendee successfully created.'
    else
      render :new, error: 'Please correct any errors present.'
    end
  end

  def edit
    @attendee_types = AttendeeType.all(order: [:name.asc])
  end

  def update
    if @attendee.update(params[:attendee])
      redirect_to attendee_path(@attendee), notice: 'Attendee successfully updated.'
    else
      render :edit, error: 'Please correct any errors present.'
    end
  end

  def destroy
    @attendee.destroy
    redirect_to attendees_path
  end

  private
  def get_attendee
    @attendee = Attendee.get(params[:id].to_i)
  end
end
