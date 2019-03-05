Rails.application.routes.draw do
  resources :profiles
  devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions"}
  resources :questions
  resources :posts
  resources :uploads
  resources :streams
  resources :comments
  resources :publications
  root 'home#index'
  post '/discussions', to: 'discussions#create'
  get '/comments/discussion_comments/:id', to:'comments#discussion_comments'

  get '/profiles/shares/:id', to:'profiles#shares'
  get '/profiles/educations/:id', to:'profiles#educations'
  get '/profiles/details/:id', to:'profiles#details'
  get '/profiles/connections/:id', to:'profiles#connections'
  get '/profiles/bookmarks/:id', to:'profiles#bookmarks'

  get '/follows/follow', to:'follows#follow'
  get '/follows/unfollow', to:'follows#unfollow'

  get '/interconnects/req', to: 'interconnects#req'
  get '/interconnects/connect', to: 'interconnects#connect'
  get '/interconnects/:id/destroy', to: 'interconnects#destroy'

  get '/likes/like', to:'likes#like'
  get '/likes/dislike', to:'likes#dislike'

  get '/bookmarks/bookmark', to:'bookmarks#bookmark'
  get '/bookmarks/unbookmark', to:'bookmarks#unbookmark'

  get '/shares/share', to:'shares#share'
  get '/shares/unshare', to:'shares#unshare'

  get '/uploads/remoted/:id', to: "uploads#remoted"

  post '/educations', to: 'educations#create'
  get '/educations/:id/destroy', to: 'educations#destroy'

  #get '/login', to: 'api#login'
  #get '/streams', to: 'api#streams'
  #post '/api/sign_up', to: 'api#sign_up'
  #post '/api/make_post', to: 'api#make_post'

  namespace 'api' do
    namespace 'v1' do
      get '/login', to: 'api#login'
      get '/streams', to: 'api#streams'
      post '/sign_up', to: 'api#sign_up'
      post '/make_post', to: 'api#make_post'
    end
    namespace 'v2' do
      get '/likes', to: 'api#likes'
      get '/like', to: 'api#like'
      get '/shares', to: 'api#shares'
      get '/share', to: 'api#share'
      get '/follows', to: 'api#follows'
      get '/follow', to: 'api#follow'
      get '/authorized', to: 'api#authorized'
      get '/bookmarks', to: 'api#bookmarks'
      get '/bookmark', to: 'api#bookmark'
      get '/streams', to: 'api#streams'
      post '/check_asset',to: 'api#check_asset'
    end
  end

end
