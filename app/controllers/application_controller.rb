class ApplicationController < ActionController::Base
  protect_from_forgery
  # check_authorization :unless => :devise_controller?

protected

  def default_to_guest_user
    unless current_user
      user = User.new
      user.remember_me!
      sign_in(user)
    end
  end
  
end
