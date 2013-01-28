class AttendancesController < ApplicationController
  include Common::Events
  before_filter :authenticate_user!
  before_filter :set_event
  before_filter :user_is_owner?, only: [:index, :update]

  def index
    @attendances = @event.attendances
  end

  def create
    @event.join current_user
    redirect_to event_path(params[:event_id])
  end

  def update
    @attendance = @event.attendances.find params[:id]
    @attendance.attributes = params[:attendance]
    @attendance.save
    redirect_to event_attendances_path(params[:event_id])
  end

  def destroy
    @event.leave current_user unless @event.user_is_owner?(current_user)
    redirect_to event_path(params[:id])
  end
end
