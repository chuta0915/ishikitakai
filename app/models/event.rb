class Event < ActiveRecord::Base
  include Common::UserCreation
  include Common::Markdown
  include Common::TimeScope
  include Polymorphic::Commentable
  self.time_scope_field = :begin_at
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
  has_many :attendances, dependent: :delete_all
  has_many :users, through: :attendances
  has_many :wikis, as: :parent
  has_many :notifications, as: :trigger, dependent: :delete_all
  belongs_to :group
  belongs_to :user
  belongs_to :scope
  belongs_to :event_payment_kind

  validates_presence_of :name, :summary, :place_name, :capacity_min, :capacity_max, :event_payment_kind_id
  validates_length_of :name, minimum: 0, maximum: 30
  validates_length_of :summary, minimum: 0, maximum: 100
  validates_length_of :content, minimum: 0, maximum: 2000
  validates :place_url, url_format: true

  scope :search, lambda {|keyword|
    where(["
      events.name LIKE ? OR 
      events.content LIKE ? OR
      events.summary LIKE ?
      ", 
      "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"
    ])
    .joins(:group)
    .where('groups.scope_id = ?', Scope.find_by_name('public').id)
  }

  after_initialize :join_date
  after_initialize :default_values, :unless => "self.persisted?"
  after_initialize :split_date
  before_create :create_attendances
  before_validation :join_date
  after_find :split_date
  after_update :update_attendance
  after_create :notify_group_event

  class << self
    def creatable?(user)
      user_ids = Figaro.env.creatable_event_user_ids.split(',')
      return true if user_ids.blank?
      return true if user_ids.include?(user.try(:id).try(:to_s))
      return false
    end
  end

  def user_is_owner?(user)
    self.user_can_edit? user
  end
  
  def user_can_edit?(user)
    attendance = self.attendances.where(user_id: user.try(:id)).first
    attendance.present? && attendance.level.name == 'master'
  end

  def user_is_attendance?(user)
    attendance = self.attendances.where(user_id: user.try(:id)).first
    attendance.present?
  end
  
  def join(user, level = 'member')
    return if self.user_is_attendance? user
    if self.attendances.count >= self.capacity_max
      level = 'pending'
    end
    if self.group.try(:user_is_owner?, user)
      level = 'master'
    end
    self.attendances << Attendance.new(
      user_id: user.try(:id),
      level_id: Level.find_by_name(level).id,
    )
  end

  def leave(user)
    return unless self.user_is_attendance? user
    self.attendances.where(user_id: user.id).first.destroy
  end

  private
  def default_values
    self.capacity_min = 0 if self.capacity_min.nil?
    self.capacity_max = 10 if self.capacity_max.nil?
    self.receive_begin_at = Time.zone.parse(Time.current.strftime('%Y-%m-%d %H:00:00')) + 1.day if self.receive_begin_at.nil?
    self.receive_end_at = self.receive_begin_at + 1.day if self.receive_end_at.nil?
    self.begin_at = self.receive_end_at if self.begin_at.nil?
    self.end_at = self.begin_at + 2.hour if self.end_at.nil?
    self.fee = 0 if self.fee.nil?
  end

  def create_attendances
    if self.user_id.present?
      self.attendances << Attendance.new(
        user_id: self.user_id, 
        level_id: Level.find_by_name(:master).id,
      )
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

  def update_attendance
    if capacity_max_changed? && capacity_max > capacity_max_was
      # capacity_maxが増えていれば繰り上がりの可能性がある
      diff = capacity_max - capacity_max_was
      self.attendances.order(:id).offset(capacity_max_was).limit(diff).each do |attendance|
        attendance.accept
      end 
    end
  end

  def notify_group_event
    return unless self.group
    users = self.try(:group).try(:users) - [self.user]
    ::Notification::GroupEvent.notify(users, self)
  end
end
