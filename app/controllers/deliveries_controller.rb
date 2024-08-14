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

  def order_create
    @order = Order.new(order_params)
    return unless @order.save

    order_item_create
  end

  def order_item_create
    @items_data = params.require(:body).require(:items)
    @order_items = []
    @items_data.each do |item|
      order_item = OrderItem.new
      order_item.quantity = item["quantity"]
      order_item.item_id = item["id"]
      order_item.order_id = @order.id
      break unless order_item.save

      @order_items << order_item
    end
    order_subitem_create
  end

  def order_subitem_create
    @subitem_ids = params.require(:body).require(:subitems)
    @subitem_ids.each do |subitem|
      order_subitem = OrderItem.new
      order_subitem.subitem_id = subitem
      order_subitem.order_id = @order.id
      break unless order_subitem.save

      @order_items << order_subitem
    end
    update_orders
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

  def login
    user = User.find_by(email: 'pablo@puente.com')
    sign_in(user) if user&.valid_password?('Pablo24bar-menu')
    order_create
  end
end
