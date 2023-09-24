class DeliveriesController < ApplicationController
    skip_before_action :authenticate_user!, only: :grequest
    def grequest
        basket_params = JSON.parse(request.body.read)

        # Now, you can access the "basket" object as a regular Ruby hash
        # For example, you can access a specific key like this:

        # Do something with the "basket" data here
        table = basket_params['table']
        # Respond with JSON data (optional)
        p "Recived: #{table} "
    end
end
