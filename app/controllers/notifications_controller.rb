class NotificationsController < ApplicationController
  layout Proc.new { |controller| controller.request.xhr? ? nil : 'application' }
  before_filter :authenticate_user!
  def index
    @notifications = current_user.notifications.order('id DESC')
  end

  def show
    @notification = current_user.notifications.find params[:id]
    @notification.read_it
  end

  def update
    Notification.read_all(current_user)
    redirect_to notifications_path
  end
end
