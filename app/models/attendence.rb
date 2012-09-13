class Attendence < ActiveRecord::Base
  attr_accessible :content, :event_id, :level_id, :user_id
  belongs_to :event
  belongs_to :user
  belongs_to :level

  after_save :notify_attendence
  after_destroy :notify_attendences

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
    level_changes = self.changes[:level_id]
    if level_changes.present? &&
        level_changes[0] == Level.find_by_name(:pending).id &&
        level_changes[1] != Level.find_by_name(:pending).id
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
end
