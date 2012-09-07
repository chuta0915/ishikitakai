class SettingsController < ApplicationController
  include Common::Users
  before_filter :authenticate_user!
  before_filter :set_user

  def show
  end
end
