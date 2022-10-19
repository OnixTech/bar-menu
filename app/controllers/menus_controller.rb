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
      @menu.company = @company.id
      if menu.save
        redirect_to companies_path(current_user)
      else
        render :new
      end
      authorize @menu
    end

    private

    def menu_params
      params.require(:menu).permit(:name)
    end

    def set_menus
      @menu = Menu.find(params[:id])
    end
end
