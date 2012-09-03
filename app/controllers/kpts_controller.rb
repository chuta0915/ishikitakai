class KptsController < ApplicationController
  include KptHelper

  before_filter Filters::NestedResourcesFilter.new
  before_filter :authenticate_user!

  def index
    @keeps = @parent.kpts.where(status: Kpt::KEEP).order('id DESC').all
    @problems = @parent.kpts.where(status: Kpt::PROBLEM).order('id DESC').all
    @trys = @parent.kpts.where(status: Kpt::TRY).order('id DESC').all
    
    @kpt = @parent.kpts.build
    respond_to do |format|
      format.html
    end
  end

  def create
    @kpt = @parent.kpts.create_by_user params[:kpt], current_user
    if @kpt.persisted?
      redirect_to kpts_path(@parent), notice: t('kpts.index.created', name: @kpt.name)
    else
      redirect_to kpts_path(@parent), alert: @kpt.errors.full_messages.join(',')
    end
  end

  def update
    @kpt = Kpt.find params[:id]
    @kpt.status = params[:kpt][:status]
    if @kpt.save
      redirect_to kpts_path(@parent), notice: t('kpts.index.updated', name: @kpt.name)
    else
      redirect_to kpts_path(@parent), alert: @kpt.errors.full_messages.join(',')
    end
  end

  def destroy
    @kpt = Kpt.find params[:id]
    @kpt.destroy
    redirect_to kpts_path(@parent), notice: t('kpts.index.destroyed', name: @kpt.name)
  end
end
