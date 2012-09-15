class UserMailer < ActionMailer::Base
  default from: "info@ishikitakai.com"

  def email_confirmation(user)
    @user = user
    if @user.valid_email.present?
      mail(:to => "#{user.name} <#{user.unconfirmed_email}>", :subject => "Confirm your email address")
    end
  end
end
