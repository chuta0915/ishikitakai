class KptsController < ApplicationController
  include Common::Groups
  include KptHelper
  before_filter :authenticate_user!
  before_filter :set_group
  before_filter :user_is_member?

  def index
    @keeps = @group.kpts.where(status: Kpt::KEEP).order('id DESC').all
    @problems = @group.kpts.where(status: Kpt::PROBLEM).order('id DESC').all
    @trys = @group.kpts.where(status: Kpt::TRY).order('id DESC').all
    
    @kpt = @group.kpts.build
    respond_to do |format|
      format.html
    end
  end

  def create
    @kpt = @group.kpts.create_by_user params[:kpt], current_user
    if @kpt.persisted?
      redirect_to kpts_path(@group), notice: t('kpts.index.created', name: @kpt.name)
    else
      redirect_to kpts_path(@group), alert: @kpt.errors.full_messages.join(',')
    end
  end

  def update
    @kpt = Kpt.find params[:id]
    @kpt.status = params[:kpt][:status]
    if @kpt.save
      redirect_to kpts_path(@group), notice: t('kpts.index.updated', name: @kpt.name)
    else
      redirect_to kpts_path(@group), alert: @kpt.errors.full_messages.join(',')
    end
  end

  def destroy
    @kpt = Kpt.find params[:id]
    @kpt.destroy
    redirect_to kpts_path(@group), notice: t('kpts.index.destroyed', name: @kpt.name)
  end
end
