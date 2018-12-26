Rails.application.routes.draw do
  resources :streams
   root 'home#index'
end
