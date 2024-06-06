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
    params.require(:order).permit(:numerference, :table, :total, :station_id, items: %i[id quantity], subitems: [])
  end

  def order_item_params
    params.require(:order)[:items]
  end

  def order_subitem_params
    params.require(:order)[:subitems]
  end

  def order_create
    @order = Order.new(order_params)
    return unless @order.save!

    order_item_create
  end

  def order_item_create
    items = order_item_params
    items.each do |item|
      order_item = OrderItem.new
      order_item.quantity = item["quantity"]
      order_item.item_id = item["id"]
      order_item.order_id = @order.id
      break unless order_item.save!
    end
    order_subitem_create
  end

  def order_subitem_create
    subitems = order_subitem_params
    subitems.each do |subitem|
      order_subitem = OrderItem.new
      order_subitem.subitem_id = subitem
      order_subitem.order_id = @order.id
      break unless order_subitem.save!
    end
    action_cable
  end

  def action_cable
    ActionCable.server.broadcast(
      "station_#{@order.station_id}",
      {
        action: "created"
      }
    )
  end

  def login
    user = User.find_by(email: 'pablo@puente.com')
    sign_in(user) if user&.valid_password?('Pablo24bar-menu')
    order_create
  end
end
