# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_cart
  def index; end

  def success_payment
    update_product_stock
    if order.save
      empty_cart
      redirect_to orders_path
    else
      flash[:warning] = 'Order could not be saved'
    end
  end

  private

  def order
    @order = Order.new
    @current_cart.line_items.each do |item|
      @order.line_items << item
      item.cart_id = nil
    end
    @order.update(quantity: @current_cart.total_quantity, total: order_total, user: current_user)
    @order
  end

  def update_product_stock
    @current_cart.line_items.each { |item| item.product.update(quantity: item.product_quantity - item.quantity) }
  end

  def order_total
    if params[:coupon]
      @current_cart.sub_total - (@current_cart.sub_total * params[:coupon].to_f)
    else
      @current_cart.sub_total
    end
  end

  def empty_cart
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end
end
