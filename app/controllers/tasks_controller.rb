class TasksController < ApplicationController
  include TaskHelper
  before_filter Filters::NestedResourcesFilter.new
  before_filter :authenticate_user!

  def index
    if params[:keyword].present?
      @tasks = @parent.tasks.search(params[:keyword])
    else
      @tasks = @parent.tasks
    end
    @task = @parent.tasks.build
    @tasks = @tasks.order('done, id DESC')
    respond_to do |format|
      format.html
    end
  end

  def create
    @task = @parent.tasks.create_by_user params[:task], current_user
    if @task.persisted?
      redirect_to tasks_path(@parent), notice: t('tasks.index.created', name: @task.name)
    else
      redirect_to tasks_path(@parent), alert: @task.errors.full_messages.join(',')
    end
  end

  def update
    @task = Task.find params[:id]
    @task.completed_user = current_user
    if @task.complete
      redirect_to tasks_path(@parent), notice: t('tasks.index.updated', name: @task.name)
    else
      redirect_to tasks_path(@parent), alert: @task.errors.full_messages.join(',')
    end
  end

  def destroy
    @task = Task.find params[:id]
    @task.destroy
    redirect_to tasks_path(@parent), notice: t('tasks.index.destroyed', name: @task.name)
  end

end
