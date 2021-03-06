class NotificationMailer < ActionMailer::Base
  layout 'notification_mailer'
  default from: "info@ishikitakai.com"

  def attend_status(user, event)
    @user = user
    @event = event
    set_locale
    mail(:to => "#{user.name} <#{user.email}>", :subject => I18n.t("notification.attend_status.change_status.name", event_name: @event.name))
  end

  def event_comment(user, event)
    @user = user
    @event = event
    set_locale
    mail(:to => "#{user.name} <#{user.email}>", :subject => I18n.t("notification.event_comment.post.name", event_name: @event.name))
  end

  def event_attendance(user, event)
    @user = user
    @event = event
    set_locale
    mail(:to => "#{user.name} <#{user.email}>", :subject => I18n.t("notification.event_attendance.add.name", event_name: @event.name))
  end

  def group_event(user, event)
    @user = user
    @event = event
    set_locale
    mail(:to => "#{user.name} <#{user.email}>", :subject => I18n.t("notification.group_event.add.name", group_name: @event.try(:group).try(:name)))
  end

  private
  def set_locale
    I18n.locale = @user.locale if @user.locale
  end
end

