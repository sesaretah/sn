Rails.application.routes.draw do
  resources :questions
  resources :posts
  resources :uploads
  resources :streams
  resources :comments
  root 'home#index'
  post '/discussions', to: 'discussions#create'
end
