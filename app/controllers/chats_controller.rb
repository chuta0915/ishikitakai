class ChatsController < ApplicationController
  include Modules::Groups
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :set_group
  before_filter :user_is_member?, :only => [:create, :destroy]

  def index
    @chats = @group.chats
  end

  def show
    @chat = Chat.find params[:id]
  end

  def create
    chat = @group.chats.build params[:chat]
    chat.user_id = current_user.id
    chat.save
    redirect_to group_chats_path(@group)
  end

  def destroy
    chat = current_user.chats.find params[:id]
    chat.destroy 
    redirect_to group_chats_path(@group)
  end
end
