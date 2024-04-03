class MenusController < ApplicationController
  before_action :set_menus, only: %i[show destroy update]

  def show
    authorize @menu
    @items = Item.where(menu_id: @menu.id)
  end

  def create
    @menu = Menu.new(menu_params)
    authorize @menu
    @menu.save!
    redirect_to company_path(@menu.company_id)
  end

  def update
    authorize @menu
    @menu.update(menu_params)
    redirect_to company_path(@menu.company_id)
  end

  def cmUpdate
    cm_params
    @menu = Menu.find(@cm[:menu_id])
    authorize @menu
    @menu.update(visible: @cm[:visible])
    redirect_to companies_path(current_user)
  end

  def destroy
    authorize @menu
    @menu.destroy!
    redirect_to company_path(current_user)
  end

  private

  def menu_params
    params.require(:menu).permit(:title, :subtitle, :company_id, :position, :visible)
  end

  def cm_params
    @cm = params.require(:menu).permit(:visible, :menu_id)

  end

  def set_menus
    @menu = Menu.find(params[:id])
  end
end
