class Notification::AttendStatus < Notification
  after_find :convert_for_locale

  class << self
    def notify_changing users, event
      params = {
        name: "notification.attend_status.change_status.name",
        content: "notification.attend_status.change_status.content",
      }
      target_users = []
      users.each do|user|
        unless self.where(user_id: user.id, trigger_type: 'Event', trigger_id: event.id).exists?
          target_users << user
        end
      end
      self.notify target_users, params, event
      target_users.each do|user|
        NotificationMailer.attend_status(user, event).deliver
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
