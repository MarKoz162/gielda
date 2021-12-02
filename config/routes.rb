Rails.application.routes.draw do
  devise_for :users
  resources :stocks
  resources :user_stocks, only: [:create, :index] 
  post "sell", to: "user_stocks#sell"
  resources :users, only: [:index]
  root 'stocks#index'
  patch "donate", to: "users#donate"
end
