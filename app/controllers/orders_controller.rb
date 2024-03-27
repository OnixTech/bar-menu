class OrdersController < ApplicationController
  before_action :set_orders, only: %i[update destroy]

  def create
    @order = Order.new(order_params)
    authorize @order
    @order.save!
  end

  def update
    authorize @order
    @order.update(order_params)
  end

  def destroy
    authorize @order
    @order.destroy!
  end

  private

  def order_params
    params.require(:order).permit(:table, :numerference, :total, :station_id)
  end

  def set_orders
    @order = Order.find(params[:id])
  end
end
