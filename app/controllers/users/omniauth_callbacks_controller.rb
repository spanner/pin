class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)

    if user && user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect user, :event => :authentication
    else
      session["facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_session_url
    end
  end

end