IshikitakaiCom::Application.routes.draw do
  mount RailsAdmin::Engine => '/management', :as => 'rails_admin'
  devise_for :admins

  root to:'pages#index'
end
