class AuthController < Devise::OmniauthCallbacksController

  Provider.order('id DESC').all.each do|provider|
    define_method provider.name do
      user = User.send("find_#{provider.name}", env["omniauth.auth"], current_user)
      if user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: provider.name
        sign_in_and_redirect user, :event => :authentication
      else
        flash[:notice] = I18n.t "devise.omniauth_callbacks.failure", kind: provider.name, reason: "User create error"
        redirect_to root_path
      end
    end
  end

  def failure
  end

  private
  def callback
  end
end
