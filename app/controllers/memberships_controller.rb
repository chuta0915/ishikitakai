class MembershipsController < ApplicationController
  include Common::Groups
  before_filter :authenticate_user!
  before_filter :set_group
  before_filter :user_is_owner?, only: [:index, :update]

  def index
    @memberships = @group.memberships
  end

  def create
    if @group.scope.name == 'private'
      @group.join current_user, 'pending'
    else
      @group.join current_user
    end
    redirect_to group_path(params[:group_id])
  end

  def update
    @membership = @group.memberships.find params[:id]
    @membership.attributes = params[:membership]
    @membership.save
    redirect_to group_memberships_path(params[:group_id])
  end

  def destroy
    @group.leave current_user unless @group.user_is_owner?(current_user)
    redirect_to group_path(params[:id])
  end
end
