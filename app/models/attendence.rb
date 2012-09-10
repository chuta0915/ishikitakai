class Attendence < ActiveRecord::Base
  attr_accessible :content, :event_id, :level_id, :user_id
  belongs_to :event
  belongs_to :user
  belongs_to :level

  after_save :notify_attendence
  after_destroy :notify_attendence

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
end
