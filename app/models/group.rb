class Group < ActiveRecord::Base
  attr_accessible :content, :name, :scope_id, :summary
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  belongs_to :scope
  attr_accessor :user_id

  validates_presence_of :name, :content, :summary, :scope_id
  validates_length_of :name, :minimum => 1, :maximum => 30
  validates_length_of :summary, :minimum => 1, :maximum => 30
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
    def create_by_user attr, user
      group = self.new attr
      group.user_id = user.try(:id)
      return group unless group.valid?
      group.save
    end
  end

  def user_is_owner? user_id
    self.user_can_edit? user_id
  end
  
  def user_can_edit? user_id
    membership = self.memberships.where(:user_id => user_id).first
    membership.present? && membership.level.name == 'master'
  end

  def content
    c = super
    c.to_md if c.present?
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
