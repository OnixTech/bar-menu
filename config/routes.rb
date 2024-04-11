Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :companies do
    get 'qr' => 'companies#qr'
    resources :stations
  end
  post '/companies/new' => 'companies#new'
  resources :menus
  post '/menus/cmUpdate' => 'menus#cmUpdate'
  post '/users/update' => 'users#update'
  post '/items/setPrices' => 'items#setPrices'
  resources :items do
    resources :subitems, only: %i[new create update destroy]
  end
  post '/bsktresqto', to: 'deliveries#grequest'
end
