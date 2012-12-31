class Attendence < ActiveRecord::Base
  attr_accessible :content, :event_id, :level_id, :user_id
  belongs_to :event
  belongs_to :user
  belongs_to :level

  before_save :check_master_level, if: Proc.new{|p| !p.new_record?}
  after_save :notify_attendence
  after_destroy :notify_attendences
  after_create :create_memberships
  after_create :notify_event_attendance

  def accept
    if self.event.group.present?
      if self.event.group.user_is_member? self.user
        self.level_id = Level.find_by_name(:member).id
      else
        self.level_id = Level.find_by_name(:guest).id
      end
    else
      self.level_id = Level.find_by_name(:guest).id
    end
    self.save!
  end

  private
  def notify_attendence
    # pendingからpending以外に変わった場合に通知する
    if level_id_changed? && level_id_was == Level.find_by_name(:pending).id
        ::Notification::AttendStatus.notify_changing [self.user], self.event
    end
  end

  def notify_attendences
    return if self.level_id == Level.find_by_name(:pending).id
    # 1つ前の参加者のレベルを変更する
    prev = Attendence.where(event_id: self.event_id).where('id > ?', self.id).order('id asc').first
    if prev.present?
      prev.accept
    end
  end

  def check_master_level
    master_level_id = Level.find_by_name('master').id

    # master以外に更新した場合は、
    # 当レコード以外にmaster以外が存在することを確認する
    unless self.level_id == master_level_id
      return self.event.attendences
        .where(level_id: master_level_id)
        .where('attendences.id NOT IN (?)', self.id)
        .exists?
    end
    true
  end

  def create_memberships
    group = self.try(:event).try(:group)
    return unless group

    group.join self.user.id
  end

  def notify_event_attendance
    users = self.try(:event).try(:users) - [self.user]
    ::Notification::EventAttendance.notify_attending(users, self.try(:event))
  end
end
