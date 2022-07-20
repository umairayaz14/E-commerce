# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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

  def current_cart
    @current_cart = Cart.find_by(id: session[:cart_id]) if session[:cart_id]

    session[:cart_id] = nil if @current_cart.nil?

    return unless session[:cart_id].nil?

    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id
  end

  private

  def record_not_found
    render '/layouts/not_found'
  end
end
