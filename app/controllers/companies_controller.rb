class CompaniesController < ApplicationController
  before_action :set_companies, only: [:show, :edit, :update, :destroy]
  
  def index
    @company = policy_scope(Company)
    if current_user.role.name == "master"
      @users = User.all
      @companies = Company.where(user_id: current_user.id)
    elsif current_user.present?
      @companies = Company.where(user_id: current_user.id)
    end
  end

  def show
    authorize @company
    @companies = Company.where(user_id: current_user)
    @menus = Menu.where(company_id: @company.id)
    @items = Item.all
    #@set_prices = { "euro" => 0.00, "percent" => 0.00 }
    @menu = Menu.new
    @item = Item.new
  end

  def new
    @company = Company.new
    @companies = Company.where(user_id: current_user)
    authorize @company
  end

  def create
    @company = Company.new(company_params)
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
    authorize @company
    @company.update(company_params)
    redirect_to companies_path(@company)
  end
  
  def destroy
    authorize @company
    @company.destroy
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :city, :suburb, :street, :number, :post, :qr_code)
  end

  def set_companies
    @company = Company.find(params[:id])
  end

  def set_all_prices
 
  end
end
