Rails.application.routes.draw do

  resources :polls
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
