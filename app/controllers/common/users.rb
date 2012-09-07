module Common::Users
  def self.included base
    return unless base < ActionController::Base
  end

  private
  def set_user
    @user = User.find current_user.id
  end
end
