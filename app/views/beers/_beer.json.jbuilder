json.extract! beer, :id, :name, :family, :price, :abv, :created_at, :updated_at
json.url beer_url(beer, format: :json)
