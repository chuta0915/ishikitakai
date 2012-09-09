class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :set_notification
  before_filter :basic_auth
  rescue_from Exception, with: :catch_exceptions unless Rails.env.test?

  private
  def set_locale
    I18n.locale = extract_locale_from_accept_language_header
    I18n.locale = :en if admin_signed_in?
  end

  def set_notification
    return unless user_signed_in?
    Notification::Basic.notify_by_key [current_user], 'confirm_email' if current_user.valid_email.blank?
  end

  def basic_auth
    return if ENV['BASIC_AUTH_USER'].nil?
    authenticate_or_request_with_http_basic do |user, pass|
      user == ENV['BASIC_AUTH_USER'] && pass == ENV['BASIC_AUTH_PW']
    end 
  end

  def catch_exceptions(e)
    logger.error e.to_yaml
        e.backtrace.each { |line| logger.error line }
    if params[:controller] == "user" && params[:action] == "show"
      render layout: false, file: "#{Rails.root}/public/404", status: 404, format:  :html
    else
      render layout: false, file: "#{Rails.root}/public/500", status: 500, format: :html
    end
  end

  def extract_locale_from_accept_language_header
    http_accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    if http_accept_language.present?
      http_accept_language.scan(/^[a-z]{2}/).first
    else
      :en
    end
  end
end
