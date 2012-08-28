IshikitakaiCom::Application.routes.draw do
  mount RailsAdmin::Engine => '/management', :as => 'rails_admin'
  devise_for :admins

  devise_for :users, :controllers => { :omniauth_callbacks => "auth" }, :skip => [:sessions]
  devise_scope :user do
    delete '/sessions' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # /my scope for current_user
  scope :path => :my do
    delete '' => 'users#destroy'
    resources :memberships, :only => [:update, :destroy], :as => :my_memberships
    resources :attendences, :only => [:update, :destroy], :as => :my_attendences
    root :to => 'users#show', :as => :my_root
  end
  resources :users, :only => [:show]
  resources :groups do
    resources :chats, :only => [:index, :show, :create, :destroy] do
    end
    resources :wikis
  end
  resources :events do
    member do
      get :copy
    end
    resources :wikis
  end
  
  post 'chats/authentication' => 'chats#authentication'

  get 'login' => 'pages#login', :as => :new_user_session
  get 'logout' => 'pages#logout', :as => :logout
  get 'about' => 'pages#about', :as => :about
  get 'terms' => 'pages#terms', :as => :terms
  get 'policy' => 'pages#policy', :as => :policy
  root :to => 'pages#index'
end
