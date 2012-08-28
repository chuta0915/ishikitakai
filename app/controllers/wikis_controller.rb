class WikisController < ApplicationController
  before_filter Filters::NestedResourcesFilter.new
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    params[:page] ||= 1
    params[:per] ||= 10
    if params[:keyword].present?
      @wikis = @parent.wikis.search(params[:keyword])
    else
      @wikis = @parent.wikis
    end
    @wikis = @wikis.order('id DESC')
      .page(params[:page])
      .per(params[:per])
    respond_to do |format|
      format.html
    end
  end

  def new
    @wiki = @parent.wikis.build
  end

  def show
    @wiki = Wiki.find params[:id]
  end

  def edit
    @wiki = Wiki.find params[:id]
  end

  def create
    @wiki = @parent.wikis.create_by_user params[:wiki], current_user
    if @wiki.persisted?
      redirect_to @parent, notice: t('wikis.show.created', name: @wiki.name)
    else
      render :new
    end
  end

  def update
    @wiki = Wiki.find params[:id]
    @wiki.attributes = params[:wiki]
    if @wiki.save
      redirect_to @parent, notice: t('wikis.show.updated', name: @wiki.name)
    else
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find params[:id]
    @wiki.destroy
    redirect_to @parent, notice: t('wikis.show.destroyed', name: @wiki.name)
  end
end
