class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :set_notification
  before_filter :basic_auth
  before_filter :restrict_save
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

  def restrict_save
    return if Rails.env.test?
    if ENV['CREATABLE_GROUP_USER_IDS'].present? &&
      request.path =~ /^\/groups/ &&
      request.method != 'GET'
      unless ENV['CREATABLE_GROUP_USER_IDS'].split(',').include? current_user.id.to_s
        return head :unauthorized
      end
    end
    if ENV['CREATABLE_EVENT_USER_IDS'].present? &&
      request.path =~ /^\/events/ &&
      request.method != 'GET'
      unless ENV['CREATABLE_EVENT_USER_IDS'].split(',').include? current_user.id.to_s
        return head :unauthorized
      end
    end
  end
end
