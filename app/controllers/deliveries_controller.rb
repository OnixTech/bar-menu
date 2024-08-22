class DeliveriesController < ApplicationController
  skip_before_action :authenticate_user!, only: :grequest
  skip_before_action :verify_authenticity_token, only: [:grequest]

  def grequest
    skip_authorization
    set_order_items
    return unless check_items

    login
  end

  private

  def order_params
    params.require(:body).require(:order).permit(:table, :numerference, :total, :station_id)
  end

  def order_create
    @order = Order.new(order_params)
    return unless @order.save

    order_items
  end

  def order_items
    flag = true
    @items_data.each do |item|
      flag = false unless order_item_create(item)
    end
    update_orders unless flag == false
  end

  def order_item_create(item)
    order_item = OrderItem.new
    order_item.order_id = @order.id
    order_item.quantity = item["quantity"]
    order_item.item_id = item["id"]
    unless item["subitem"].blank?
      order_item.subitem_id = item["subitem"][0]
      @subitem_ids << item["subitem"][0]
    end
    return false unless order_item.save

    @order_items << order_item
    return true
  end

  def update_orders
    set_update
    Turbo::StreamsChannel.broadcast_prepend_to("station_#{@order.station_id}",
                                               target: "orders",
                                               partial: "stations/order",
                                               locals: { order: @order,
                                                         order_items: @order_items,
                                                         subitems: @subitems,
                                                         items: @items })
  end

  def set_update
    items_id = @items_data.map { |item| item["id"] }
    @items = Item.where(id: items_id)
    @subitems = Subitem.where(id: @subitem_ids)
  end

  def set_order_items
    @items_data = params.require(:body).require(:items)
    @order_items = []
    @subitem_ids = []
  end

  def check_items
    flag = true
    @items_data.each do |item_data|
      next if item_data["subitem"].blank?

      item_data["subitem"].each do |item_subitem|
        subitem = Subitem.find_by(id: item_subitem)
        if item_data["id"] != subitem.item_id
          flag = false
          logger.warn "Unknwon child"
          break
        end
      end
    end
    return flag
  end

  def login
    user = User.find_by(email: 'pablo@puente.com')
    sign_in(user) if user&.valid_password?('Pablo24bar-menu')
    order_create
  end
end
