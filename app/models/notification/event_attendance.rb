class Notification::EventAttendance < Notification
  after_find :convert_for_locale

  class << self
    def notify_attending users, event
      params = {
        name: "notification.event_attendance.add.name",
        content: "notification.event_attendance.add.content",
      }
      target_users = []
      users.each do|user|
        target_users << user
      end
      self.notify target_users, params, event
      target_users.each do|user|
        if user.valid_email.present? && user.setting.mail_event_attendance
          if ENV['DELAYED'] == '1'
            NotificationMailer.delay.event_attendace(user, event)
          else
            NotificationMailer.event_attendance(user, event).deliver
          end
        end
      end
    end
  end

  def read_it
    self.reload
    super
  end

  private
  def convert_for_locale
    self.name = I18n.t(self.name, event_name: self.trigger.name)
    self.content = I18n.t(self.attributes['content'], event_name: self.trigger.name, event_url: Rails.application.routes.url_helpers.event_path(self.trigger.id))
  end
end
