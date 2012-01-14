class AttendeesController < ApplicationController
  respond_to :html, :json

  before_filter :get_attendee, only: [:show, :edit, :update, :destroy]
  before_filter :set_label_options_on_cookie, only: [:show]

  def index
    direction = params[:sSortDir_0] || "asc"
    @attendees = Attendee.all(
      :last_name.like => "%#{params[:sSearch]}%", limit: params[:iDisplayLength].to_i,
      offset: params[:iDisplayStart].to_i, order: [:last_name.send(direction)]
    )
    @iTotalRecords = Attendee.count
    @iTotalDisplayRecords = Attendee.count(:last_name.like => "%#{params[:sSearch]}%")
    @sEcho = params[:sEcho].to_i
    respond_with @attendees
  end

  def show
  end

  def new
    @attendee = Attendee.new
    @attendee_types = AttendeeType.all(order: [:name.asc])
  end

  def create
    @attendee = Attendee.new(params[:attendee])
    @attendee_types = AttendeeType.all(order: [:name.asc])
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
    @attendee_types = AttendeeType.all(order: [:name.asc])
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

  def set_label_options_on_cookie
    prefs = Preference.first
    initialize_cookie_tracker(
      :print_label => prefs.print_label, :create_qrcode => prefs.create_qrcode,
      :label_options => prefs.label_options.to_hash.keys, :qrcode_options => prefs.qrcode_options
    )
  end

  private
  def get_attendee
    @attendee = Attendee.get(params[:id].to_i)
  end
end
