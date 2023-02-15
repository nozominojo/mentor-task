Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:index, :show]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

  resources :perfumes

  resources :tags do
    get 'tweets', to: 'tweets#search'
  end


  root 'tweets#index'
end
