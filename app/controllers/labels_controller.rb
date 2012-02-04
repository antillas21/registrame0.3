class LabelsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_label, only: [:show, :edit, :update, :destroy]

  def index
    @labels = Label.all
  end

  def show
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(params[:label])
    if @label.save
      redirect_to labels_path, notice: 'Label successfully created.'
    else
      render :new, error: 'Please correct any errors present.'
    end
  end

  def edit
  end

  def update
    if @label.update(params[:label])
      redirect_to @label, notice: 'Label successfully updated.'
      set_format_cookies
    else
      render :edit, error: 'Please correct any errors present.'
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, notice: 'Label successfully deleted.'
  end

  private
  def get_label
    @label = Label.get(params[:id].to_i)
  end
end
