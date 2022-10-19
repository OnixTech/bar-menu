class CompaniesController < ApplicationController

  def index
    @company = policy_scope(Company)
  end

  def show
    @company = Company.find(current_user.id)
    authorize @company
    @companies = Company.where(user_id: current_user)
    @menus = Menu.where(company_id: @company.id)
  end

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(companies_params)
    @company.user = current_user
    if @company.save
      redirect_to companies_path(current_user)
    else
      render :new
    end
    authorize @company
  end

  def edit
    authorize @company
  end

  def update
    if @company = Company.update(company_params)
      redirect_to @company
    else
      redirect_to :edit
    authorize @company
    end
  end
  
  def destroy
    @company.destroy
    redirect_to companies_path
    authorize @company
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

  def set_companies
    @company = Company.find(params[:id])
  end
end
