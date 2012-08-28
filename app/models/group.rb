class Group < ActiveRecord::Base
  include Common::UserCreation
  include Common::Markdown

  attr_accessible :content, :name, :scope_id, :summary
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :events
  has_many :chats
  has_many :wikis, :as => :parent
  belongs_to :scope
  attr_accessor :user_id

  validates_presence_of :name, :content, :summary, :scope_id
  validates_length_of :name, :minimum => 0, :maximum => 30
  validates_length_of :summary, :minimum => 0, :maximum => 30
  validates_length_of :content, :minimum => 0, :maximum => 2000

  scope :search, lambda {|keyword| where(["
    name LIKE ? OR 
    summary LIKE ? OR
    content LIKE ?
    ", 
    "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"
  ])}

  before_create :create_memberships

  class << self
    def collection_select user_id
      groups = self
        .joins(:memberships)
        .where('memberships.user_id = ? ', user_id)
        .order('memberships.updated_at DESC')
        .all
      groups.unshift Group.new(:name => I18n.t('group.records.none'), :content => 'none', :summary => 'none') 
      groups
    end
  end

  def user_is_owner? user_id
    self.user_can_edit? user_id
  end
  
  def user_can_edit? user_id
    membership = self.memberships.where(:user_id => user_id).first
    membership.present? && membership.level.name == 'master'
  end

  def user_is_member? user_id
    membership = self.memberships.where(:user_id => user_id).first
    membership.present?
  end

  def join user_id, level = 'member'
    return if self.user_is_member? user_id
    self.memberships << Membership.new(
      :user_id => user_id, 
      :level_id => Level.find_by_name(level).id)
  end

  def leave user_id
    return unless self.user_is_member? user_id
    self.memberships.where(:user_id => user_id).first.destroy
  end

  private
  def create_memberships
    if self.user_id.present?
      self.memberships << Membership.new(
        :user_id => self.user_id, 
        :level_id => Level.find_by_name(:master).id)
    else
      false
    end
  end
end
