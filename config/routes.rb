Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :clock_events, only: %i(index create destroy)
  resources :users, only: %i(edit update)
end
