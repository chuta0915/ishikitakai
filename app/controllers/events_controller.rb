class EventsController < ApplicationController
  include Common::Events
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :set_event, only: [:edit, :update, :destroy, :copy]
  before_filter :user_can_edit?, only: [:edit, :update, :destroy, :copy]

  def index
    params[:page] ||= 1
    params[:per] ||= 9 
    if params[:keyword].present?
      @events = Event.search params[:keyword]
    elsif params[:group_id].present?
      @events = Group.find(params[:group_id]).events
    else
      @events = Event
    end
    @events = @events
      .where(scope_id: Scope.find_by_name('public').id)
      .order('id DESC')
      .page(params[:page])
      .per(params[:per])
  end

  def show
    @event = Event.find params[:id]
  end

  def new
    @event = Event.new params[:event]
    @event.group_id = params[:group_id]
  end

  def create
    @event = Event.create_by_user params[:event], current_user
    if @event.persisted?
      redirect_to @event, notice: t('events.show.created', name: @event.name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @event.attributes = params[:event]
    if @event.save
      redirect_to @event, notice: t('events.show.updated', name: @event.name)
    else
      render :edit
    end
  end

  def copy
    @event = Event.new @event.attributes.except('id', 'created_at', 'updated_at')
    render :new 
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: t('events.show.destroyed', name: @event.name)
  end
end
