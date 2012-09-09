class Notification::Basic < Notification
  after_find :convert_for_locale

  class << self
    def notify_by_key users, key
      params = {
        name: "notification.basic.#{key}.name",
        content: "notification.basic.#{key}.content",
      }
      target_users = []
      users.each do|user|
        unless self.where(user_id: user.id).where(name: params[:name]).exists?
          target_users << user
        end
      end
      self.notify target_users, params, nil
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
