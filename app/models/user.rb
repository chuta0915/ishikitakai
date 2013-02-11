require 'open-uri'
require 'digest/md5'
class User < ActiveRecord::Base
  include Common::Storable
  include Common::Markdown
  storable_file :image

  devise :rememberable, :trackable, :omniauthable
  attr_accessible :remember_me, :name, :image, :default_provider_id, :email
  has_many :providers_users, dependent: :destroy
  has_many :providers, through: :providers_users
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :chats
  has_many :notifications
  has_one :setting, :class_name => 'UserSetting'

  validates_presence_of :email
  before_create :create_setting
  after_create :save_to_s3 # Common::Storable

  extend Providers::Facebook
  extend Providers::Twitter
  extend Providers::Github

  
  class << self
    def find_by_path(provider_name, user_key)
      providers_user = ProvidersUser.where(provider_id: Provider.send(provider_name).id, user_key: user_key).first
      self.find providers_user.user_id
    end
  end

  def valid_email
    if self.email =~ /\.example\.com$/
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
  
  def has_provider?(provider)
    self.providers_users.select(:provider_id).map{|providers_user|providers_user.provider_id}.include? provider.id
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

  def me?(user)
    return self.id == user.id
  end

  def update_email(email)
    self.unconfirmed_email = email
    self.confirm_limit_at = Time.current + 3.hour
    self.hash_to_confirm_email = confirm_key
    if self.save
      if ENV['DELAYED'] == '1'
        UserMailer.delay.email_confirmation(self)
      else
        UserMailer.email_confirmation(self).deliver
      end
    end
  end

  def confirm_email(hash)
    if hash == self.hash_to_confirm_email && Time.current <= self.confirm_limit_at
      self.email = self.unconfirmed_email
      self.unconfirmed_email = nil
      self.confirm_limit_at = nil
      self.hash_to_confirm_email = nil
      self.save!
    end
  end

  def update_name_and_image(name, image)
    self.name = name
    self.image = image
    if self.image_content_changed?
      self.save_to_s3
    else
      self.image = self.image_was
    end
    self.save!
  end

  def image_content_changed?
    return true unless self.image_was
    return true unless Digest::MD5.hexdigest(open(self.image).read) == Digest::MD5.hexdigest(open(self.image_was).read)
    return false
  end

  private
  def confirm_key
    Digest::SHA1.hexdigest("#{self.id}#{Time.current.to_i}")
  end

  def create_setting
    self.setting = UserSetting.new
  end
end
