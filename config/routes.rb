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
  resources :items
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

end
