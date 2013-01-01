class Notification::GroupEvent < Notification
  include Notification::EmailSendable
  after_find :convert_for_locale

  class << self
    def params
      {
        name: "notification.group_event.add.name",
        content: "notification.group_event.add.content",
      }
    end

    def target_users(users, trigger)
      users
    end
  end

  private
  def convert_for_locale
    self.name = I18n.t(self.name, group_name: self.trigger.group.name)
    self.content = I18n.t(self.attributes['content'], event_name: self.trigger.name, event_url: Rails.application.routes.url_helpers.event_path(self.trigger.id))
  end
end
