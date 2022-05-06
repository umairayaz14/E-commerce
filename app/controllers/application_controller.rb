class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def user_not_authorized
    flash[:warning] = 'You are not authorized to perform this action.'
    redirect_to user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :username, :avatar) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:avatar, :username, :email, :password, :current_password)
    end
  end
end
