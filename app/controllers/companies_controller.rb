class CompaniesController < ApplicationController
  before_action :set_companies, only: %i[show edit update destroy indexMenuList]
  def index
    @company = policy_scope(Company)
    @company.sort_by(&:id)
    set_master_role
    set_qr
    @menus = current_user.menus
    @menus.sort_by(&:position)
    @stations = current_user.stations
  end

  def show
    authorize @company
    @companies = Company.where(user_id: current_user)
    @main_station_id = Station.where(company_id: @company.id, name: "Main station").pluck(:id).first
    set_menus
    set_items
    set_subitems
  end

  def new
    @company = Company.new
    @companies = Company.where(user_id: current_user)
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    @company.user = current_user
    if @company.save
      main_station
      redirect_to companies_path
    else
      render :new
    end
  end

  def edit
    authorize @company
    @menus = Menu.where(company_id: @company)
  end

  def update
    authorize @company
    @company.update(company_params)
    redirect_to companies_path
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

  def set_menus
    @menus = Menu.where(company_id: @company.id)
    @menus = @menus.sort_by(&:position)
    @menu = Menu.new
  end

  def set_items
    @items = @company.items
    @items = @items.sort_by(&:position)
    @item = Item.new
  end

  def set_subitems
    @subitems = @company.subitems
    @subitem = Subitem.new
  end

  def set_qr
    @company.each do |company|
      next unless company.qr_code

      @qr_code = RQRCode::QRCode.new(company.qr_code)
      @svg = @qr_code.as_svg(offset: 0, color: '000', shape_rendering: 'crispEdges', module_size: 1, standalone: true)
    end
  end

  def set_master_role
    if current_user.role.name == "master"
      @users = User.all
      @users = User.order(id: :desc)
      @companies = Company.where(user_id: current_user.id)
    elsif current_user.present?
      @companies = Company.where(user_id: current_user.id)
    end
  end

  def main_station
    station = Station.new
    station.name = "Main station"
    station.company_id = @company.id
    station.save!
  end
end
