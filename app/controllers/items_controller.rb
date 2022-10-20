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
      if @item = Item.update(item_params)
        redirect_to @menu
      else
        redirect_to :edit
        authorize @item
      end
    end
      
    def destroy
      @item.destroy
      redirect_to menu_path
      authorize @item
    end
    
    private
    
    def item_params
      item.require(:item).permit(:name)
    end
    
    def set_items
      @item = Item.find(params[:id])
    end
end
