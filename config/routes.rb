Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :manufacturers, only: [:index, :show, :new, :create, :edit, :update]

  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]

  resources :car_categories, only: [:index, :show, :new, :create, :edit, :update]

  resources :clients, only: [:index, :show, :new, :create, :edit, :update]

  resources :car_models, only: [:index, :show, :new, :create]

  resources :cars, only: [:index, :show, :new, :create]

  resources :rentals, only: [:index, :show, :new, :create]
end
