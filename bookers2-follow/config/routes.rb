Rails.application.routes.draw do
  devise_for :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books do
    resources :book_comments
  end
  resources :relationships,  only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  root 'home#top'
  get 'home/about'
end