module Notification::EmailSendable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def notify(users, trigger)
      targets = self.target_users(users, trigger) 
      super(targets, self.params, trigger)
      targets.each do|user|
        method_name = self.to_s.split('::')[1].underscore
        user_setting_column_name = "mail_#{method_name}"
        if user.valid_email.present? && user.setting.send(user_setting_column_name)
          if Figaro.env.delayed == '1'
            NotificationMailer.delay.send(method_name, user, trigger)
          else
            NotificationMailer.send(method_name, user, trigger).deliver
          end
        end
      end
    end
  end
end
