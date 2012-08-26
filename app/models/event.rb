class Event < ActiveRecord::Base
  include Common::UserCreation
  attr_accessible :begin_at, :capacity_max, :capacity_min,
    :content, :end_at, :event_payment_kind_id, :fee,
    :group_id, :name, :place_address, :place_map_url,
    :place_name, :place_url, 
    :receive_begin_at, :receive_end_at, :scope_id, :summary,
    :title, :user_id,
    :begin_date, :begin_time, :end_date, :end_time,
    :receive_begin_date, :receive_begin_time, :receive_end_date, :receive_end_time
  attr_accessor :begin_date, :begin_time, :end_date, :end_time,
    :receive_begin_date, :receive_begin_time, :receive_end_date, :receive_end_time
  has_many :attendences, :dependent => :destroy
  has_many :users, :through => :attendences
  belongs_to :group
  belongs_to :user
  belongs_to :scope
  belongs_to :event_payment_kind

  validates_presence_of :name, :summary, :place_name, :capacity_min, :capacity_max, :event_payment_kind_id
  validates_length_of :name, :minimum => 0, :maximum => 30
  validates_length_of :summary, :minimum => 0, :maximum => 100
  validates_length_of :content, :minimum => 0, :maximum => 2000

  scope :search, lambda {|keyword| where(["
    name LIKE ? OR 
    content LIKE ? OR
    summary LIKE ?
    ", 
    "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"
  ])}

  after_initialize :default_values
  before_create :create_attendences
  before_validation :join_date
  after_find :split_date

  def content
    c = super
    c = '' if c.nil?
    c.to_md
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
  def default_values
    self.capacity_min = 0
    self.capacity_max = 10
    self.receive_begin_at = Time.zone.parse(Time.now.strftime('%Y-%m-%d %H:15:00')) + 1.day
    self.receive_end_at = self.receive_begin_at + 1.day
    self.begin_at = self.receive_end_at
    self.end_at = self.begin_at + 2.hour
    self.fee = 0
    split_date
  end

  def create_attendences
    if self.user_id.present?
      self.attendences << Attendence.new(
        :user_id => self.user_id, 
        :level_id => Level.find_by_name(:master).id)
    else
      false
    end
  end

  def join_date
    self.begin_at = Time.zone.parse "#{self.begin_date} #{self.begin_time}"
    self.end_at = Time.zone.parse "#{self.end_date} #{self.end_time}"
    self.receive_begin_at = Time.zone.parse "#{self.receive_begin_date} #{self.receive_begin_time}"
    self.receive_end_at = Time.zone.parse "#{self.receive_end_date} #{self.receive_end_time}"
  end

  def split_date
    self.begin_date = self.begin_at.to_date
    self.begin_time = self.begin_at.to_s(:time)
    self.end_date = self.end_at.to_date
    self.end_time = self.end_at.to_s(:time)
    self.receive_begin_date = self.receive_begin_at.to_date
    self.receive_begin_time = self.receive_begin_at.to_s(:time)
    self.receive_end_date = self.receive_end_at.to_date
    self.receive_end_time = self.receive_end_at.to_s(:time)
  end
end
