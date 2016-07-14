Rails.application.routes.draw do

  resources :polls
  match '/polls/:id/voting' => 'polls#voting', via: [:get], :as => :voting_poll
  match '/mypolls' => 'polls#my_index', via: [:get], :as => :my_polls

  post '/votes' => 'votes#create'

  resource :profile, only: [:show, :update, :edit]
  resources :flats
  resources :posts

  root 'welcome#index'

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  resources :users do
    resources :emails, only: [:index, :show, :new, :create, :destroy]
  end

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
