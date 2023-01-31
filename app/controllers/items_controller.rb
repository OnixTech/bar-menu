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
      set_prices = Array.new
      set_prices[0] = params[:euro].to_f
      set_prices[1] = params[:percent].to_f
      set_prices[2] = params[:menu]
      if set_prices[0] != 0.00 || set_prices[1] != 0.00
        set_all_prices(set_prices[0], set_prices[1], set_prices[2])
      else
        @item.update(item_params)
      end
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

    def set_all_prices(euro, percent, menu)
      @items = Item.where(menu_id: menu)
      @items.each do |item| 
        item.price = item.price + euro + item.price*(percent/100)
        item.update(:price => item.price)
      end
    end
end
