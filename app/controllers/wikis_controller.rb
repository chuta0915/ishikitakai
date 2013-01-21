class WikisController < ApplicationController
  include WikiHelper
  before_filter Filters::NestedResourcesFilter.new
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :user_is_member?
  before_filter :user_is_attendance?

  def index
    page = params[:page] || 1
    per = params[:per] || 10
    if params[:keyword].present?
      wikis = @parent.wikis.search(params[:keyword])
    else
      wikis = @parent.wikis
    end
    @wikis = wikis.order('id DESC')
      .page(page)
      .per(per)
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
      redirect_to wikis_path(@parent), notice: t('wikis.show.created', name: @wiki.name)
    else
      render :new
    end
  end

  def update
    @wiki = Wiki.find params[:id]
    @wiki.attributes = params[:wiki]
    if @wiki.save
      redirect_to wiki_path(@parent, @wiki), notice: t('wikis.show.updated', name: @wiki.name)
    else
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find params[:id]
    @wiki.destroy
    redirect_to wikis_path(@parent), notice: t('wikis.show.destroyed', name: @wiki.name)
  end

  private
  def user_is_member?
    return unless  @parent.is_a? Group
    @group = @parent
    return render 'groups/navigate' unless @parent.user_is_member? current_user
  end

  def user_is_attendance?
    return unless  @parent.is_a? Event
    return head :not_found unless @parent.user_is_attendance? current_user
  end
end
