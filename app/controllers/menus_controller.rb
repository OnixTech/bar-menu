class MenusController < ApplicationController
    before_action :set_menus, only:[:show, :destroy, :update]
    
    def show
      authorize @menu
      @items = Item.where(menu_id: @menu.id)
    end

    def create
      @menu = Menu.new(menu_params)
      authorize @menu
      @menu.save!
      redirect_to company_path(current_user)
    end

    def update
      authorize @menu
      @menu.update(menu_params)
      redirect_to company_path(current_user)
    end

    def destroy
      authorize @menu
      @menu.destroy!
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
