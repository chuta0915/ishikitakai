class KptsController < ApplicationController
  include Common::Groups
  include KptHelper
  before_filter :authenticate_user!
  before_filter :set_group
  before_filter :user_is_member?
  layout Proc.new { |controller| controller.request.xhr? ? nil : 'application' }

  def index
    @keeps = @group.kpts.where(status: Kpt::KEEP).order('priority DESC').all
    @problems = @group.kpts.where(status: Kpt::PROBLEM).order('priority DESC').all
    @trys = @group.kpts.where(status: Kpt::TRY).order('priority DESC').all
    
    @kpt = @group.kpts.build
    respond_to do |format|
      format.html
    end
  end

  def create
    @kpt = @group.kpts.create_by_user params[:kpt], current_user
    if @kpt.persisted?
      Pusher["presence-group_kpts_#{@group.id}"].trigger('updated', nil) unless Rails.env.test?
      redirect_to kpts_path(@group), notice: t('kpts.index.created', name: @kpt.name)
    else
      redirect_to kpts_path(@group), alert: @kpt.errors.full_messages.join(',')
    end
  end

  def update
    @kpt = Kpt.find params[:id]
    @kpt.priority_ids = params[:priority_ids]
    @kpt.status = params[:kpt][:status]
    if @kpt.save
      Pusher["presence-group_kpts_#{@group.id}"].trigger('updated', nil) unless Rails.env.test?
      redirect_to kpts_path(@group), notice: t('kpts.index.updated', name: @kpt.name)
    else
      redirect_to kpts_path(@group), alert: @kpt.errors.full_messages.join(',')
    end
  end

  def destroy
    @kpt = Kpt.find params[:id]
    @kpt.destroy
    Pusher["presence-group_kpts_#{@group.id}"].trigger('updated', nil) unless Rails.env.test?
    if request.xhr?
      head :ok
    else
      redirect_to kpts_path(@group), notice: t('kpts.index.destroyed', name: @kpt.name)
    end
  end
end
