class Event < ActiveRecord::Base
  include Common::UserCreation
  attr_accessible :begin_at, :capacity_max, :capacity_min,
    :content, :end_at, :event_payment_kind_id, :fee,
    :group_id, :name, :place_address, :place_map_url,
    :place_name, :place_url, 
    :receive_begin_at, :receive_end_at, :scope_id, :summary,
    :title, :user_id
  has_many :attendences, :dependent => :destroy
  has_many :users, :through => :attendences
  belongs_to :user
  belongs_to :scope
  belongs_to :event_payment_kind

  validates_presence_of :name, :summary, :place_name, :capacity_max, :capacity_min, :event_payment_kind_id
  validates_length_of :name, :minimum => 1, :maximum => 30
  validates_length_of :summary, :minimum => 1, :maximum => 100
  validates_length_of :content, :minimum => 0, :maximum => 2000

  scope :search, lambda {|keyword| where(["
    name LIKE ? OR 
    content LIKE ? OR
    summary LIKE ?
    ", 
    "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"
  ])}

  before_create :create_attendences

  def content
    c = super
    c.to_md if c.present?
  end
  
  def user_is_owner? user_id
    self.user_can_edit? user_id
  end
  
  def user_can_edit? user_id
    attendence = self.attendences.where(:user_id => user_id).first
    attendence.present? && attendence.level.name == 'master'
  end

  def user_is_attendence? user_id
    attendence = self.attendences.where(:user_id => user_id).first
    attendence.present?
  end
  
  def join user_id, level = 'member'
    return if self.user_is_attendence? user_id
    self.attendences << Attendence.new(
      :user_id => user_id, 
      :level_id => Level.find_by_name(level).id)
  end

  def leave user_id
    return unless self.user_is_attendence? user_id
    self.attendences.where(:user_id => user_id).first.destroy
  end

  private
  def create_attendences
    if self.user_id.present?
      self.attendences << Attendence.new(
        :user_id => self.user_id, 
        :level_id => Level.find_by_name(:master).id)
    else
      false
    end
  end
end
