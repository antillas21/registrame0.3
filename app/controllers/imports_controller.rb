class ImportsController < ApplicationController
  before_filter :authenticate_user!

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
    @previous_count = Attendee.count

    perform_import_process(@import.document.path)

    @final_count = Attendee.count
    if @final_count != @previous_count
      msg = "Successfully imported #{@final_count - @previous_count} records."
    else
      msg = "No records were imported."
    end

    @import.destroy

    redirect_to imports_path, notice: msg
  end

  private
  def perform_import_process(file)
    CSV.foreach(file, headers: true, col_sep: ";") do |row|
      row = row.to_hash.symbolize_keys!
      [
        :first_name, :last_name, :email, :registration, :phone, :company_name,
        :address, :city, :state_name, :country_name
      ].each do |attr|
        if row.keys.include?(attr)
          row[attr] = "" if row[attr].nil?
        end
      end
      #row[:phone] = clean_phone_numbers(row[:phone]) if row.keys.include?(:phone)

      Attendee.create(row)
    end
  end

  def clean_phone_numbers(row_phone_number)
    row_phone_number.gsub!(/\D/, "")
    if row_phone_number.length > 10
      row_phone_number = row_phone_number[0..9] 
    end
    return row_phone_number
  end
end
