module Common::Events
  def self.included(base)
    return unless base < ActionController::Base
  end

  private
  def set_event
    id = params[:event_id] ? params[:event_id] : params[:id]
    @event = Event.find id
  end

  def user_is_owner?
    return head :not_found unless @event.user_is_owner? current_user
  end

  def user_can_edit?
    return head :not_found unless @event.user_can_edit? current_user
  end
end
