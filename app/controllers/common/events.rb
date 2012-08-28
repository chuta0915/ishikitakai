module Common::Events
  def self.included base
    return unless base < ActionController::Base
  end

  private
  def set_event
    @event = Event.find params[:id]
  end

  def user_can_edit?
    return head :not_found unless @event.user_can_edit? current_user.id
  end
end
