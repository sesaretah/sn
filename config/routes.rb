Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions"}
  resources :questions
  resources :posts
  resources :uploads
  resources :streams
  resources :comments
  root 'home#index'
  post '/discussions', to: 'discussions#create'
  get '/comments/discussion_comments/:id', to:'comments#discussion_comments'

end
