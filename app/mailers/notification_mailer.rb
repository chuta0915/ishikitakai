class NotificationMailer < ActionMailer::Base
  default from: "info@ishikitakai.com"

  def attend_status(user, event)
    @user = user
    @event = event
    mail(:to => "#{user.name} <#{user.email}>", :subject => I18n.t("notification.attend_status.change_status.name"))
  end
end

