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
  resources :groups
  resources :events do
    member do
      get :copy
    end
  end

  get 'login' => 'pages#login', :as => :new_user_session
  get 'logout' => 'pages#logout', :as => :logout
  root :to => 'pages#index'
end
