class AttendencesController < ApplicationController
  include Common::Events
  before_filter :authenticate_user!
  before_filter :set_event
  before_filter :user_is_owner?, only: [:index, :update]

  def index
    @attendences = @event.attendences
  end

  def create
    @event.join current_user.id
    redirect_to event_path(params[:event_id])
  end

  def update
    @attendence = @event.attendences.find params[:id]
    @attendence.attributes = params[:attendence]
    @attendence.save
    redirect_to event_attendences_path(params[:event_id])
  end

  def destroy
    @event.leave current_user.id unless @event.user_is_owner?(current_user.id)
    redirect_to event_path(params[:id])
  end
end
