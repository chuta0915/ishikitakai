class Notification::EventComment < Notification
  after_find :convert_for_locale

  class << self
    def notify users, event
      params = {
        name: "notification.event_comment.post.name",
        content: "notification.event_comment.post.content",
      }
      target_users = []
      users.each do|user|
        target_users << user
      end
      super target_users, params, event
      target_users.each do|user|
        if user.valid_email.present? && user.setting.mail_attend_status
          if ENV['DELAYED'] == '1'
            NotificationMailer.delay.event_comment(user, event)
          else
            NotificationMailer.event_comment(user, event).deliver
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
