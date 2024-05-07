require 'httparty'
require 'net/http'
require 'json'

class DeliveriesController < ApplicationController
  skip_before_action :authenticate_user!, only: :grequest
  before_action :set_cors_headers, only: [:grequest]
  def grequest
    skip_authorization
    #------------ Domains Config -------------#

    login
  end

  private

  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, X-CSRF-Token'
    headers['Access-Control-Max-Age'] = '1728000' # 20 days
  end

  def delivary_params
    @orders = []
    basket_params = JSON.parse(request.body.read)
    #basket_params["items"].each do |item|
     # stations << item.station_id if item.station_id != stations.last
    #end
    order = {
      table: basket_params["table"],
      numbereference: basket_params["numbereference"],
      total: basket_params["total"],
      station_id: 3
    }
    #stations.each do |station|
     # order["station_id"] = station
      #new_order = Order.new(order)
    order.save!
    #end
  end

  def login
    user = User.find_by(email: 'pablo@puente.com')
    sign_in(user) if user&.valid_password?('Pablo24bar-menu')
    delivary_params
  end

  def create_order
    delivary_params
    orders = []
    order_items = []
    company = Company.find_by(name: @order[:company])
    stations = Station.where(company_id: company)

    stations.each do |station|
      acumulator = 0.00
      order = {
        table: @order[:table],
        numerference: 0,
        total: @order[:total],
        station_id: station.id
      }

      @order[:items].each do |item|
        if station.name == item[:station_id]
          order_items << item
          acumulator += item["price"] * item["quantity"]
        end
      end
      if order_items.size.positive?
        order[:total] = acumulator
        orders << order
      end
    end
    session[:orders] = orders
    session[:order_items] = order_items
    redirect_to new_order_path
  end
end
