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
    params.require(:item).permit(:name, :price, :description, :op_a, :op_b, :op_c, :op_d, :op_e,
      :price_a, :price_b, :price_c, :price_d, :price_e, :price_io, :menu_id, :position)
  end

  def set_items
    @item = Item.find(params[:id])
  end
end
