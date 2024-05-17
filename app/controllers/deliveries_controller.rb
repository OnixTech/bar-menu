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
    params.require(:order).permit(:table, :numerference, :total, :station_id)
  end

  def delivary_params
    order = Order.new(order_params)
    if order.save!
      ActionCable.server.broadcast(
        "station_#{order.station_id}",
        {
          action: "created"
        }
      )
    end
  end

  def login
    user = User.find_by(email: 'pablo@puente.com')
    sign_in(user) if user&.valid_password?('Pablo24bar-menu')
    delivary_params
  end
end
