Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
