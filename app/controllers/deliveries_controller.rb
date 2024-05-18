require 'httparty'
require 'net/http'
require 'json'

class DeliveriesController < ApplicationController
  skip_before_action :authenticate_user!, only: :grequest
  skip_before_action :verify_authenticity_token, only: [:grequest]

  def grequest
    skip_authorization
    login
  end

  private

  def order_params
    params.require(:body).require(:order).permit(:table, :numerference, :total, :station_id)
  end

  def order_item_params
    params.require(:body).permit(items: [])
  end

  def order_create
    @order = Order.new(order_params)

    return unless @order.save!

    order_item_create
    ActionCable.server.broadcast(
      "station_#{@order.station_id}",
      {
        action: "created"
      }
    )
  end

  def order_item_create
    items = order_item_params
    items.each do |item|
      order_item = OrderItem.new
      order_item.quantity = item.quantity
      order_item.id = item.id
      order_item.order_id = @order.id
    end
  end

  def login
    user = User.find_by(email: 'pablo@puente.com')
    sign_in(user) if user&.valid_password?('Pablo24bar-menu')
    order_create
  end
end
