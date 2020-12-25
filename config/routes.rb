Rails.application.routes.draw do

  get 'home/about'
  devise_for :users
  root to: 'home#top'
  resources :books
  resources :users, only: [:show, :index, :edit, :update]
end
