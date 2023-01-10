class ItemsController < ApplicationController
    before_action :set_items

    def new
      @company = Company.new
      authorize @item
    end
    
    def create
      @item = Item.new(items_params)
      @item.menu = @menu.id
      if @item.save
        redirect_to menu_path(current_user)
      else
        render :new
      end
      authorize @item
    end
    
    def edit
      authorize @item
    end
    
    def update
      @item = Item.find(params[:id])
      @item.update(item_params)
      #redirect_to @menu
      #authorize @item
    end
      
    def destroy
      @item.destroy
      redirect_to menu_path
      authorize @item
    end
    
    private
    
    def item_params
      params.require(:item).permit(:name,:price,:description)
    end
    
    def set_items
      @item = Item.find(params[:id])
    end
end
