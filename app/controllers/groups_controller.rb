class GroupsController < ApplicationController
  include Common::Groups
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :set_group, only: [:edit, :update, :destroy, :join, :leave]
  before_filter :user_can_edit?, only: [:edit, :update, :destroy]
  respond_to :html, :json
  def index
    page = params[:page] || 1
    per = params[:per] || 9
    if params[:keyword].present?
      groups = Group.search params[:keyword]
    else
      groups = Group
    end
    @groups = groups
      .where(scope_id: Scope.find_by_name('public').id)
      .order('id DESC')
      .page(page)
      .per(per)
    respond_to do |format|
      format.html
      format.json { 
        render json: {
          page: params[:page],
          per: params[:per],
          total: Group.count,
          models: ActiveSupport::JSON.decode(@groups.to_json(current_user: current_user)),
        } 
      }
    end
  end

  def show
    @group = Group.find params[:id]
    @today_event = @group.events.today.first

    unless @group.scope.name == 'public'
      render :show_guest unless @group.user_is_member? current_user
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create_by_user params[:group], current_user
    if @group.persisted?
      redirect_to @group, notice: t('groups.show.created', name: @group.name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @group.attributes = params[:group]
    if @group.save
      redirect_to @group, notice: t('groups.show.updated', name: @group.name)
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: t('groups.show.destroyed', name: @group.name)
  end
end
