class Notification::EventComment < Notification
  include Notification::EmailSendable
  after_find :convert_for_locale

  class << self
    def params
      {
        name: "notification.event_comment.post.name",
        content: "notification.event_comment.post.content",
      }
    end

    def target_users(users, trigger)
      users
    end
  end

  private
  def convert_for_locale
    self.name = I18n.t(self.name, event_name: self.trigger.name)
    self.content = I18n.t(self.attributes['content'], event_name: self.trigger.name, event_url: Rails.application.routes.url_helpers.event_path(self.trigger.id))
  end
end
