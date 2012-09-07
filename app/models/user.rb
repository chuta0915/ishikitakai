class User < ActiveRecord::Base
  devise :rememberable, :trackable, :omniauthable
  attr_accessible :remember_me, :name, :image, :default_provider_id, :email
  has_many :providers_users, dependent: :destroy
  has_many :providers, through: :providers_users
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :chats
  has_many :notifications

  extend Providers::Facebook
  extend Providers::Twitter
  extend Providers::Github
  
  class << self
    def find_by_path provider_name, user_key
      providers_user = ProvidersUser.where(provider_id: Provider.send(provider_name).id, user_key: user_key).first
      self.find providers_user.user_id
    end
  end

  def valid_email
    if email =~ /\.example\.com$/
      return ''
    end
    self.email
  end
  
  def user_key
    self.providers_users.where(provider_id: self.default_provider_id).first.user_key
  end
  
  def default_provider
    Provider.select('id, name').find self.default_provider_id
  end
  
  def has_provider? provider_id
    self.providers_users.select(:provider_id).map{|providers_user|providers_user.provider_id}.include? provider_id
  end
  
  def has_all_provider?
    self.providers_users.length === Provider.all.length
  end

  def as_json(options = {})
    json = super(options)
    current_user = options[:current_user]
    if current_user.present?
      json[:mine] = (current_user.id == self.id)
    end
    return json
  end

  def me? user
    return self.id == user.id
  end

  def update_email email
    self.unconfirmed_email = email
    self.confirm_limit_at = Time.current + 3.hour
    self.hash_to_confirm_email = confirm_key
    self.save!
    UserMailer.email_confirmation(self).deliver
  end

  def confirm_email hash
    if hash == self.hash_to_confirm_email && Time.current <= self.confirm_limit_at
      self.email = self.unconfirmed_email
      self.unconfirmed_email = nil
      self.confirm_limit_at = nil
      self.hash_to_confirm_email = nil
      self.save!
    end
  end

  private
  def confirm_key
    Digest::SHA1.hexdigest("#{self.id}#{Time.current.to_i}")
  end
end
