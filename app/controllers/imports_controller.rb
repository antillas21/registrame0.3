class ImportsController < ApplicationController
  def index
    @imports = Import.last
    @import = Import.new
  end

  def new
    @import = Import.new
  end

  def show
    @import = Import.get(params[:id].to_i)
  end

  def create
    @import = Import.new(params[:import])
    if @import.save
      redirect_to imports_path, notice: "You have uploaded a new import .csv file."
    else
      render :index, alert: "Please correct the errors present."
    end
  end

  def destroy
    @import = Import.get(params[:id])
    @import.destroy
    redirect_to imports_path, notice: 'You have deleted an import .csv file'
  end
end
