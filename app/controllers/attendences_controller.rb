class AttendencesController < ApplicationController
  include Modules::Events
  before_filter :authenticate_user!
  before_filter :set_event
  def update
    @event.join current_user.id
    redirect_to Rails.application.routes.url_helpers.event_path(params[:id])
  end

  def destroy
    @event.leave current_user.id unless @event.user_is_owner?(current_user.id)
    redirect_to Rails.application.routes.url_helpers.event_path(params[:id])
  end
end
