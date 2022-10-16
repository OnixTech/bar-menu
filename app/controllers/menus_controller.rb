class MenusController < ApplicationController

    def show
      @menu = Company.find(params[:id])
    end

    def new
      @menu = Menu.new
    end

    def create
      @menu = Menu.new(menu_params)
      @menu.company = @company.id

    private

    def menu_params
      params.require(:menu).permit(:name)
    end

    def set_menus
      @menu = Menu.find(params[:id])
    end
end
