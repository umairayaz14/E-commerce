# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :current_cart
  before_action :set_cart

  def destroy
    if @current_cart.destroy
      session[:cart_id] = nil
      redirect_to root_path
    else
      flash[:alert] = 'Unable to empty cart!'
    end
  end

  private

  def set_cart
    @current_cart.update(user_id: current_user.id) if user_signed_in?
  end
end
