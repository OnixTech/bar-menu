require 'httparty'
require 'net/http'
require 'json'

class DeliveriesController < ApplicationController
  skip_before_action :authenticate_user!, only: :grequest

  def grequest
    skip_authorization
    #------------ Domains Config -------------#
    if Rails.env.production?
      policy_origin = "https://fillo.herokuapp.com/bsktresqto"
      endpoint = "https://fillo-admin-2d8ec2766e12.herokuapp.com/bsktreq"
    else
      policy_origin = "http://127.0.0.1:3001/bsktresqto"
      endpoint = "http://127.0.0.1:3000/bsktreq"
    end
    #------------ Policy Config -------------#
    csp_policy = "default-src 'self'; script-src 'self' 'unsafe-inline';"
    csp_policy += "connect-src 'self' #{policy_origin};"
    response.headers['Content-Security-Policy'] = csp_policy
    login
  end

  private

  def delivary_params
    basket_params = JSON.parse(request.body.read)
    @order = {
      company: basket_params["company"],
      table: basket_params["table"],
      items: basket_params["items"],
      total: basket_params["total"]
    }
  end

  def login
    user = User.find_by(email: 'pablo@puente.com')
    sign_in(user) if user&.valid_password?('Pablo24bar-menu')
    create_order
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
