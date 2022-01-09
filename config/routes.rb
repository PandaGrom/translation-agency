require 'sidekiq/web'

Rails.application.routes.draw do
  get 'home/index'

  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: %i[update index show]

  namespace :admin do
    resources :comments, only: %i[destroy index]
  end

  resources :orders do
    resources :comments, only: %i[create destroy]
    patch 'take', on: :member
    patch 'close', on: :member
    patch 'open', on: :member
    get 'export_csv_file', on: :member
  end

  resources :categories

  resources :comments

  root to: 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
