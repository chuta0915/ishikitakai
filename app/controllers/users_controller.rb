class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_filter :set_current_user, only: [:edit, :update]

  def show
    begin
      user_id = params[:id] || current_user.id
      @user = User.find user_id 
    rescue => e
      logger.error e.message
      return head :not_found
    end
    respond_to do|f|
      f.html
      f.json do
        render :json => @user.to_json(current_user: current_user.present? ? current_user : nil)
      end
    end
  end

  def edit
    
  end

  def update
    if @user.update_attribute(:content, params[:user][:content])
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    user = User.find current_user.id
    user.destroy
    redirect_to root_path, notice: t('users.withdraw.completed')
  end

  private
  def set_current_user
    @user = User.find(current_user.id)
  end
end
