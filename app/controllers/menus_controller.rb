class MenusController < ApplicationController

    def show
      @menu = Menu.find(params[:id])
      authorize @menu
      @items = Item.where(menu_id: @menu.id)
    end

    def new
      @menu = Menu.new
      authorize @menu
    end

    def create
      @menu = Menu.new(menu_params)
      authorize @menu
      @menu.save!
      redirect_to company_path(current_user)
    end

    private

    def menu_params
      params.require(:menu).permit(:title, :subtitle, :company_id)
    end

    def set_menus
      @menu = Menu.find(params[:id])
    end
end
