Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users do
    get 'block', on: :member
    get 'unblock', on: :member
  end

  namespace :admin do
    resources :comments, only: %i[destroy index]
  end

  resources :orders do
    resources :comments, only: %i[create destroy]
  end

  resources :categories

  resources :comments

  root to: 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
