IshikitakaiCom::Application.routes.draw do
  mount RailsAdmin::Engine => '/management', :as => 'rails_admin'
  devise_for :admins

  devise_for :users, :controllers => { :omniauth_callbacks => "auth" }, :skip => [:sessions]
  devise_scope :user do
    delete '/sessions' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # /my scope for current_user
  scope :path => :my do
    resources :notifications, :only => [:index, :show]
    delete '' => 'users#destroy'
    resources :memberships, :only => [:destroy], :as => :my_memberships
    resources :attendances, :only => [:destroy], :as => :my_attendances
    resource :email, :only => [:show, :edit, :update] do
      member do
        get 'confirmation/:hash' => :confirmation, :hash => /[0-9a-f]+/, :as => :confirmation
      end
    end
    resource :setting, :only => [:show, :edit, :update], :as => :my_setting
    root :to => 'users#show', :as => :my_root
  end
  resources :users, :only => [:show]
  resources :groups do
    resources :memberships, :only => [:index, :create, :update]
    resources :chats, :only => [:index, :show, :create, :destroy] do
    end
    resources :wikis
    resources :tasks, :only => [:index, :create, :update, :destroy]
    resources :kpts, :only => [:index, :create, :update, :destroy]
  end

  resources :comments, :only => [:show, :destroy]
  
  resources :events do
    resources :attendances, :only => [:index, :create, :update]
    member do
      get :copy
    end
    resources :wikis
    resources :comments, :only => [:create]
  end
  
  post 'pusher/authentication' => 'pushers#authentication'

  get 'login' => 'pages#login', :as => :new_user_session
  get 'logout' => 'pages#logout', :as => :logout
  get 'about' => 'pages#about', :as => :about
  get 'terms' => 'pages#terms', :as => :terms
  get 'policy' => 'pages#policy', :as => :policy
  root :to => 'pages#index'
end
