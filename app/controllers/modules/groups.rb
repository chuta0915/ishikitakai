module Modules::Groups
  def self.included base
    return unless base < ActionController::Base
  end

  private
  def set_group
    @group = Group.find params[:id]
  end

  def user_can_edit?
    return head :not_found unless @group.user_can_edit? current_user.id
  end
end
