Rails.application.routes.draw do
  root 'sessions#new'

  resources :users
  resources :sessions

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
