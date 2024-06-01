Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join('|')}/ do
    root to: "pages#home"

    devise_for :users do
      get '/users/sign_out' => 'devise/sessions#destroy'
    end

    resources :users do
      get 'index' => 'users#index'
    end

    resources :companies do
      get 'qr' => 'companies#qr'
      resources :stations, only: %i[show create edit destroy]
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
end
