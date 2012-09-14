class SettingsController < ApplicationController
  include Common::Users
  before_filter :authenticate_user!
  before_filter :set_user

  def show
    redirect_to edit_my_setting_path
  end

  def edit
    @user_setting = current_user.setting
  end

  def update
    @user_setting = current_user.setting
    @user_setting.attributes = params[:user_setting]
    if @user_setting.save
      redirect_to edit_my_setting_path, notice: t('settings.show.updated')
    else
      render :show
    end
  end
end
