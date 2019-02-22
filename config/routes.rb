Rails.application.routes.draw do
  resources :profiles
  devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions"}
  resources :questions
  resources :posts
  resources :uploads
  resources :streams
  resources :comments
  root 'home#index'
  post '/discussions', to: 'discussions#create'
  get '/comments/discussion_comments/:id', to:'comments#discussion_comments'

  get '/profiles/shares/:id', to:'profiles#shares'
  get '/profiles/educations/:id', to:'profiles#educations'
  get '/profiles/details/:id', to:'profiles#details'

  get '/follows/follow', to:'follows#follow'
  get '/follows/unfollow', to:'follows#unfollow'

  get '/likes/like', to:'likes#like'
  get '/likes/dislike', to:'likes#dislike'

  get '/shares/share', to:'shares#share'
  get '/shares/unshare', to:'shares#unshare'

  get '/uploads/remoted/:id', to: "uploads#remoted"

  post '/educations', to: 'educations#create'
  get '/educations/:id/destroy', to: 'educations#destroy'
end
