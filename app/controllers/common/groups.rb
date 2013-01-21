module Common::Groups
  def self.included base
    return unless base < ActionController::Base
  end

  private
  def set_group
    id = params[:group_id] ? params[:group_id] : params[:id]
    @group = Group.find id
  end
  
  def user_is_owner?
    return head :not_found unless @group.user_is_owner? current_user
  end

  def user_can_edit?
    return head :not_found unless @group.user_can_edit? current_user
  end

  def user_is_member?
    return render 'groups/navigate' unless @group.user_is_member? current_user
  end
end
