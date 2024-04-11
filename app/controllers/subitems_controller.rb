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
    if @subitem.update(subitem_params)
      redirect_to @subitem, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @subitem.destroy
    respond_to do |format|
      format.html { render js: "window.location.reload();" }
      format.js   { render :reload_page }
    end
  end

  private

  def subitem_params
    params.require(:subitem).permit(:name, :description, :price, :sumitem, :item_id)
  end

  def set_subitems
    @subitem = Subitem.find(params[:id])
  end
end
