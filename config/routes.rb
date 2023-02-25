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
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

end
