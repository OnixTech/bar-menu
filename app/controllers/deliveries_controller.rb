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
    #------------ Object Config -------------#
    basket_params = JSON.parse(request.body.read)
    order = {
      email: 'pablo@puente.com',
      password: 'Pablo24bar-menu',
      company: basket_params["company"],
      table: basket_params["table"],
      items: basket_params["items"],
      total: basket_params["total"]
    }
    basket = {
      email: 'pablo@puente.com',
      password: 'Pablo24bar-menu',
      company: basket_params["company"],
      table: basket_params["table"],
      items: basket_params["items"],
      total: basket_params["total"]
    }
  end
end
