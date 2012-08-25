class ProvidersUser < ActiveRecord::Base
  attr_accessible :access_token, :email, :image, :name, :provider_id, :refresh_token, :secret, :user_id, :user_key
  belongs_to :provider
  belongs_to :user
end
