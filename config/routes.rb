Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :companies do
    get 'qr' => 'companies#qr'
  end
  post '/companies/new' => 'companies#new'
  resources :menus
  post '/menus/cmUpdate' => 'menus#cmUpdate'
  post '/users/update' => 'users#update'
  post '/items/setPrices' => 'items#setPrices'
  resources :items
  post '/bsktresqto', to: 'deliveries#grequest'
  resources :stations
  resources :subitems, only: %i[create update destroy]
end
