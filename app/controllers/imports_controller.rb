class ImportsController < ApplicationController
  def index
    @imports = Import.last
    @import = Import.new
    @current_count = Attendee.count
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

  def import
    @import = Import.get(params[:id])
    @import_file = @import.document.path
    @previous_count = Attendee.count
    perform_import_process

    @final_count = Attendee.count

    if @final_count != @previous_count
      msg = "Successfully imported #{@final_count - @previous_count} records."
    else
      msg = "No records were imported."
    end
    redirect_to imports_path, notice: msg
  end

  private
  def perform_import_process
    CSV.foreach(@import_file, headers: true) do |row|
      row = row.to_hash.symbolize_keys!
      [
        :first_name, :last_name, :email, :registration, :phone, :company_name,
        :address, :city, :state_name, :country_name
      ].each do |attr|
        if row.keys.include?(attr)
          row[attr] = "" if row[attr].nil?
        end
      end

      Attendee.create(row)
    end
  end
end
