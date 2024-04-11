class SubitemsController < ApplicationController
  before_action :set_subitem, only: %i[edit update destroy]

  def create
    @item = Item.find(params[:item_id])
    @subitem = @item.subitems.build(subitem_params)
    authorize @subitem
    if @subitem.save
      redirect_to request.referrer, notice: 'Subitem was successfully created.'
    end
  end

  def edit
    @subitem
  end

  def update
    authorize @subitem
    @subitem.update(subitem_params)
    redirect_to request.referrer, notice: 'Subitem was successfully created.'
  end

  def destroy
    @subitem.destroy
  end

  private

  def subitem_params
    params.require(:subitem).permit(:name, :description, :price, :sumitem, :item_id)
  end

  def set_subitem
    @subitem = Subitem.find(params[:subitem][:subitem_id])
  end
end
