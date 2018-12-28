Rails.application.routes.draw do
  resources :questions
  resources :questions
  resources :posts
  resources :uploads
  resources :streams
  root 'home#index'
  post '/discussions', to: 'discussions#create'
end
