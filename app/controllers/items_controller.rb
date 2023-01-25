class ItemsController < ApplicationController
    before_action :set_items, only: [:update, :destroy]
    
    def create
      @item = Item.new(item_params)
      authorize @item
      @item.save!
      redirect_to company_path(current_user)
    end
      
    def update
      authorize @item
      @item.update(item_params)
      redirect_to company_path(current_user)
    end
      
    def destroy
      authorize @item
      @item.destroy!
      redirect_to company_path(current_user) 
    end
    
    private
    
    def item_params
      params.require(:item).permit(:name,:price,:description,:menu_id)
    end
    
    def set_items
      @item = Item.find(params[:id])
    end
end
