class ItemsController < ApplicationController
  before_action :set_items, only: [:update, :destroy]

  def create
    @item = Item.new(item_params)
    authorize @item
    @item.save!
    redirect_to company_path(@item.menu.company_id)
  end

  def update
    authorize @item
    @item.update(item_params)
    redirect_to company_path(current_user)
  end

  def setPrices
    @items = Item.where(menu_id: params[:menu])
    authorize @items[0]
    @items.each do |item|
      item.price = item.price + params[:euro].to_f + (item.price * (params[:percent].to_f / 100))
      item.update(:price => item.price)
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
    params.require(:item).permit(:name,:description, :price, :menu_id, :position, :station)
  end

  def set_items
    @item = Item.find(params[:id])
  end
end
