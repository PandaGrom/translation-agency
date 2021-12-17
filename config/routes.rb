Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users

  resources :orders
  
  root to: 'home#index'

  # get '/orders', to: 'orders#index'
  # get '/orders/new', to: 'orders#new'
  # post '/orders', to: 'orders#create'
 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
