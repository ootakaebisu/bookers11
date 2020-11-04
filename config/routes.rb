Rails.application.routes.draw do

  devise_for :users

  root 'home#show'
  get 'home/about'
  resources :users
  resources :books

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
