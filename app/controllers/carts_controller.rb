# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :current_cart
  before_action :set_cart

  def show
    @cart = @current_cart
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

  private

  def set_cart
    @current_cart.update(user_id: current_user.id) if user_signed_in?
  end
end
