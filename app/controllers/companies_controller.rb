class CompaniesController < ApplicationController
  respond_to :json, :html

  before_filter :find_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all(
      #conditions: ['name LIKE ?', "%#{params[:sSearch]}%"], limit: params[:iDisplayLength].to_i,
      :name.like => "%#{params[:sSearch]}%", limit: params[:iDisplayLength].to_i,
      offset: params[:iDisplayStart].to_i, order: [:name.asc]
    )
    @iTotalRecords = Company.count
    @iTotalDisplayRecords = Company.all(conditions: ['name LIKE ?', "%#{params[:sSearch]}%"]).count
    @sEcho = params[:sEcho].to_i
    respond_with @companies
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      redirect_to @company, notice: 'Company successfully created.'
    else
      render :new, error: 'There was an error saving a new company, please try again.'
    end
  end

  def show

  end

  def edit

  end

  def update
    if @company.update(params[:company])
      redirect_to company_path(@company), :notice => 'Company has been successfully updated.'
    else
      render 'edit', :error => 'An error ocurred, please check all mandatory fields.'
    end
  end

  def destroy
    @company.destroy

    redirect_to companies_path, :notice => 'Company has been successfully deleted.'
  end

  private

  def find_company
    @company = Company.get(params[:id].to_i)
  end
end
