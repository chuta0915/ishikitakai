class Admin < ActiveRecord::Base
  devise :database_authenticatable, :trackable
  attr_accessible :name, :email, :password, :password_confirmation
end
