class InterestsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_interest, :only => [:show, :edit, :update, :destroy]

  def index
    @interests = Interest.all
  end

  def new
    @interest = Interest.new
  end

  def create
    @interest = Interest.new(params[:interest])
    if @interest.save
      redirect_to interests_path, :notice => 'New interest has been added.'
    else
      render 'new', :error => 'An error ocurred, please check for mandatory fields.'
    end
  end

  def show

  end

  def edit

  end

  def update
    if @interest.update(params[:interest])
      redirect_to interests_path, :notice => 'Interest has been successfully updated.'
    else
      render 'edit', :error => 'An error ocurred, please check for mandatory fields.'
    end
  end

  def destroy
    @interest.destroy
    redirect_to interests_path, :notice => 'Interest has been successfully deleted.'
  end

  private
  def find_interest
    @interest = Interest.get(params[:id])
  end
end
