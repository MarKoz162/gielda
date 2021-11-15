Rails.application.routes.draw do
  devise_for :users
  resources :stocks
  root 'stocks#index'
  get "All_users", to: "users#index"
  patch "donate", to: "users#donate"
end
