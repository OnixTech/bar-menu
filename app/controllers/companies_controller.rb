class CompaniesController < ApplicationController
  before_action :set_companies, only: [:show, :edit, :update, :destroy, :indexMenuList]
  def index
    @company = policy_scope(Company)
    if current_user.role.name == "master"
      @users = User.all
      @companies = Company.where(user_id: current_user.id)
    elsif current_user.present?
      @companies = Company.where(user_id: current_user.id)
    end
    @company.each do |company|
      if company.qr_code
        @qr_code = RQRCode::QRCode.new(company.qr_code)
        @svg = @qr_code.as_svg(
          offset: 0,
          color: '000',
          shape_rendering: 'crispEdges',
          module_size: 1,
          standalone: true
        )
      end
    end
    menus = Menu.all
    @menus = Array.new
    menus.each do |menu|
      if menu.company.user == current_user
        @menus.push(menu)
      end
    end
    @menus.sort_by(&:position)
    @company.sort_by(&:id)
    @users = User.order(id: :desc)
  end

  def show
    authorize @company
    @companies = Company.where(user_id: current_user)
    @menus = Menu.where(company_id: @company.id)
    @menus = @menus.sort_by(&:position)
    @items = Item.all
    @items = @items.sort_by(&:position)
    @subitems = Subitem.all
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

  def qr
    @company = Company.find(params[:company_id])
    authorize @company
    @qr_code = RQRCode::QRCode.new(@company.qr_code)
    @svg = @qr_code.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 5,
      standalone: true
    )
  end

  private

  def company_params
    params.require(:company).permit(:name, :city, :suburb, :street, :number, :post, :qr_code)
  end

  def set_companies
    @company = Company.find(params[:id])
  end

end
