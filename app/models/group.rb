class Group < ActiveRecord::Base
  include Common::UserCreation
  include Common::Markdown

  attr_accessible :content, :name, :scope_id, :summary
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :events
  has_many :chats
  has_many :wikis, :as => :parent
  has_many :tasks
  has_many :kpts
  belongs_to :scope
  attr_accessor :user_id

  validates_presence_of :name, :summary, :scope_id
  validates_length_of :name, minimum: 0, maximum: 30
  validates_length_of :summary, minimum: 0, maximum: 30
  validates_length_of :content, minimum: 0, maximum: 2000

  scope :search, lambda {|keyword| where(["
    name LIKE ? OR 
    summary LIKE ? OR
    content LIKE ?
    ", 
    "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"
  ])}

  before_create :create_memberships

  class << self
    def collection_select(user)
      groups = self
        .joins(:memberships)
        .where('memberships.user_id = ? ', user.try(:id))
        .order('memberships.updated_at DESC')
        .all
      groups.unshift Group.new(name: I18n.t('group.records.none'), content: 'none', summary: 'none') 
      groups
    end
  end

  def user_is_owner?(user)
    self.user_can_edit? user
  end
  
  def user_can_edit?(user)
    membership = self.memberships.where(user_id: user.try(:id)).first
    membership.present? && membership.level.name == 'master'
  end

  def user_is_member?(user)
    membership = self.memberships.where(user_id: user.try(:id)).first
    if membership.present?
      return membership.level.name != 'pending'
    end
  end

  def user_is_in?(user)
    membership = self.memberships.where(user_id: user.try(:id)).first
    membership.present?
  end

  def user_is_pending?(user)
    membership = self.memberships.where(user_id: user.try(:id)).first
    membership.present? && membership.level.name == 'pending'
  end

  def join(user, level = 'member')
    return if self.user_is_in? user
    self.memberships << Membership.new(
      user_id: user.try(:id), 
      level_id: Level.find_by_name(level).id
    )
  end

  def leave(user)
    return unless self.user_is_member? user
    self.memberships.where(user_id: user.try(:id)).first.destroy
  end

  private
  def create_memberships
    if self.user_id.present?
      self.memberships << Membership.new(
        user_id: self.user_id, 
        level_id: Level.find_by_name(:master).id
      )
    else
      false
    end
  end
end
