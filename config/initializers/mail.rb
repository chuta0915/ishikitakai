ActionMailer::Base.smtp_settings = {
  :address        => ENV['MAIL_HOST'],
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => ENV['MAIL_DOMAIN'],
}
ActionMailer::Base.delivery_method = :smtp
