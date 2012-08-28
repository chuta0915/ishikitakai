class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:destroy]
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
  
  def destroy
    user = User.find current_user.id
    user.destroy
    redirect_to root_path, notice: t('users.withdraw.completed')
  end
end
