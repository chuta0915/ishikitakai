class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]
  before_filter Filters::NestedResourcesFilter.new
  before_filter :set_comment, only: [:show, :destroy]
  before_filter :user_is_owner?, only: [:destroy]

  def show
  end

  def create
    @comment = @parent.comments.build(params[:comment])
    if user_signed_in?
      @comment.user_id = current_user.id
    end
    if @comment.save
      redirect_to @parent, notice: t('comments.created')
    else
      redirect_to @parent, alert: @comment.errors.full_messages.join('')
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: t('comments.destroyed')
  end

  private
  def set_comment
    @comment = Comment.find params[:id]
  end

  def user_is_owner?
    return head :not_found unless @comment.user_is_owner? current_user.id
  end
end
