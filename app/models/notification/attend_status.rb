class Notification::AttendStatus < Notification
  include Notification::EmailSendable
  after_find :convert_for_locale

  class << self
    def params
      {
        name: "notification.attend_status.change_status.name",
        content: "notification.attend_status.change_status.content",
      }
    end

    def target_users(users, trigger)
      targets = []
      users.each do|user|
        unless self.where(user_id: user.id, trigger_type: 'Event', trigger_id: trigger.id).exists?
          targets << user
        end
      end
      targets
    end
  end

  private
  def convert_for_locale
    self.name = I18n.t(self.name, event_name: self.trigger.name)
    self.content = I18n.t(self.attributes['content'], event_name: self.trigger.name, event_url: Rails.application.routes.url_helpers.event_path(self.trigger.id))
  end
end
