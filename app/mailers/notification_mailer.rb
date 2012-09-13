class NotificationMailer < ActionMailer::Base
  default from: "info@ishikitakai.com"

  def attend_status(user, event)
    @user = user
    @event = event
    if @user.valid_email.present? && @user.setting.mail_attend_status
      mail(:to => "#{user.name} <#{user.email}>", :subject => I18n.t("notification.attend_status.change_status.name"))
    end
  end
end

