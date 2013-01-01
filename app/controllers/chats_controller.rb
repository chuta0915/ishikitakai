class ChatsController < ApplicationController
  include Common::Groups
  before_filter :authenticate_user!
  before_filter :set_group
  before_filter :user_is_member?
  layout Proc.new { |controller| controller.request.xhr? ? nil : 'application' }

  def index
    page = params[:page] || 1
    per = params[:per] || 100
    @chats = @group.chats
      .order('id DESC')
      .page(page)
      .per(per)
    @chats.reverse!
    @chat = Chat.new
  end

  def show
    @chat = Chat.find params[:id]
  end

  def create
    @chat = @group.chats.build params[:chat]
    @chat.user_id = current_user.id
    if @chat.save
      Pusher["presence-group_chats_#{@group.id}"].trigger('chat', id: @chat.id) unless Rails.env.test?
    end

    respond_to do |format|
      format.html do
        redirect_to group_chats_path(@group)
      end
      format.js do
        render :show
      end
    end
  end

  def destroy
    chat = current_user.chats.find params[:id]
    chat.destroy 
    redirect_to group_chats_path(@group)
  end
end
