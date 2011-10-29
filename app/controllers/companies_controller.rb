class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def show
    @company = Company.get(params[:id])
  end

  def edit
    @company = Company.get(params[:id])
  end

  def update
    @company = Company.get(params[:id])
    if @company.update(params[:company])
      redirect_to company_path(@company), :notice => 'Company has been successfully updated.'
    else
      render 'edit', :error => 'An error ocurred, please check all mandatory fields.'
    end
  end

  def destroy
    @company = Company.get(params[:id])
    @company.destroy

    redirect_to companies_path, :notice => 'Company has been successfully deleted.'
  end
end
