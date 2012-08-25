class EventsController < ApplicationController
  include Modules::Events
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :set_event, :only => [:edit, :update, :destroy]
  before_filter :user_can_edit?, :only => [:edit, :update, :destroy]

  def index
    params[:page] ||= 1
    params[:per] ||= 9 
    if params[:keyword].present?
      @events = Event.search params[:keyword]
    else
      @events = Event
    end
    @events = @events.order('id DESC')
      .page(params[:page])
      .per(params[:per])
  end

  def show
    @event = Event.find params[:id]
  end

  def new
    @event = Event.new
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

  def destroy
    @event.destroy
    redirect_to events_path, notice: t('events.show.destroyed', name: @event.name)
  end
end
