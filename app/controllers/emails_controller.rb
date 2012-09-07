class EmailsController < ApplicationController
  include Common::Users
  before_filter :authenticate_user!
  before_filter :set_user

  def show
    redirect_to edit_email_path
  end

  def edit
  end

  def update
    if @user.update_email params[:email]
      redirect_to my_root_path, notice: t('emails.updated')
    else
      render :edit
    end
  end

  def confirmation
    if @user.confirm_email params[:hash]
      redirect_to my_root_path, notice: t('emails.confirmation.complete')
    else
      redirect_to my_root_path, alert: t('emails.confirmation.error')
    end
  end
end
