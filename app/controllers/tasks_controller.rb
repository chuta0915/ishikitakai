class TasksController < ApplicationController
  include Common::Groups
  include TaskHelper
  before_filter :authenticate_user!
  before_filter :set_group
  before_filter :user_is_member?

  def index
    if params[:keyword].present?
      tasks = @group.tasks.search(params[:keyword])
    else
      tasks = @group.tasks
    end
    @task = @group.tasks.build
    todo = tasks.where(done: false).order('id DESC')
    done = tasks.where(done: true).order('id DESC')
    @tasks = todo + done 
    respond_to do |format|
      format.html
    end
  end

  def create
    @task = @group.tasks.create_by_user params[:task], current_user
    if @task.persisted?
      redirect_to tasks_path(@group), notice: t('tasks.index.created', name: @task.name)
    else
      redirect_to tasks_path(@group), alert: @task.errors.full_messages.join(',')
    end
  end

  def update
    @task = Task.find params[:id]
    @task.completed_user = current_user
    if @task.complete
      redirect_to tasks_path(@group), notice: t('tasks.index.updated', name: @task.name)
    else
      redirect_to tasks_path(@group), alert: @task.errors.full_messages.join(',')
    end
  end

  def destroy
    @task = Task.find params[:id]
    @task.destroy
    redirect_to tasks_path(@group), notice: t('tasks.index.destroyed', name: @task.name)
  end

end
