class Notification::Basic < Notification
  after_find :convert_for_locale

  class << self
    def notify_by_key users, key
      params = {
        name: "notification.basic.#{key}.name",
        content: "notification.basic.#{key}.content",
      }
      self.notify users, params, nil
    end
  end

  def read_it
    self.reload
    super
  end

  private
  def convert_for_locale
    self.name = I18n.t(self.name)
    self.content = I18n.t(self.attributes['content'])
  end
end
