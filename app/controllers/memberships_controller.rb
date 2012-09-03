class MembershipsController < ApplicationController
  include Common::Groups
  before_filter :authenticate_user!
  before_filter :set_group
  def update
    if @group.scope.name == 'private'
      @group.join current_user.id, 'pending'
    else
      @group.join current_user.id
    end
    redirect_to group_path(params[:id])
  end

  def destroy
    @group.leave current_user.id unless @group.user_is_owner?(current_user.id)
    redirect_to group_path(params[:id])
  end
end
