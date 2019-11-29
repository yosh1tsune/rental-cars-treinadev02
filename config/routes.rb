Rails.application.routes.draw do
  root to: 'home#index'

  resources :manufacturers #, only: [:index, :show...] Preferível usar whitelist

  resources :subsidiaries #, except [:destroy, :update...] Ao invés de blacklist

  resources :car_categories
end
