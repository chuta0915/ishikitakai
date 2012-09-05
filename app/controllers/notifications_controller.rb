class NotificationsController < ApplicationController
  layout Proc.new { |controller| controller.request.xhr? ? nil : 'application' }
  before_filter :authenticate_user!
  def index
    @notifications = current_user.notifications
  end

  def show
    @notification = current_user.notifications.find params[:id]
    @notification.read_it
  end
end
