Tweetbay::Application.routes.draw do
  resources :users
  resources :users
  resources :contents
  resources :sessions, only: [:create, :new, :destroy]
  resources :image_contents, only: [:create]

  root "contents#index"

  get "splash", :to => "splash#index", :as => "splash"
  get "howitworks", :to => "splash#howitworks", :as => "howitworks"
  get "aboutus", :to => "splash#aboutus", :as => "aboutus"

  get "onboard", :to => "contents#onboard", :as => "onboard"

  get "logout", :to => "sessions#destroy", :as => "logout"
  get "login", :to => "sessions#new", :as => "login"
  get "signup", :to => "users#new", :as => "signup"
  get "post", :to => "contents#new", :as => "post"

  get "auth/twitter", :as => "twitter_auth"
  get "auth/:provider/callback", :to => "sessions#create"

  post '/contents/create_reply', controller: 'contents', action: 'create_reply'
  

end
