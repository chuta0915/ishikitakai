class MembershipsController < ApplicationController
  include Common::Groups
  before_filter :authenticate_user!
  before_filter :set_group
  def update
    @group.join current_user.id
    redirect_to group_path(params[:id])
  end

  def destroy
    @group.leave current_user.id unless @group.user_is_owner?(current_user.id)
    redirect_to group_path(params[:id])
  end
end
