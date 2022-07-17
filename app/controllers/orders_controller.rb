# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def create
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
    current_cart.line_items.each do |item|
      @order.line_items << item
      item.cart_id = nil
    end
    @order.quantity = current_cart.total_quantity
    @order.total = current_cart.sub_total
    @order.user = current_user
    @order
  end

  def update_product_stock
    current_cart.line_items.each { |item| item.product.update(quantity: item.product_quantity - item.quantity) }
  end

  def empty_cart
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end
end
