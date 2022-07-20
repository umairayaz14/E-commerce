# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :current_cart
  before_action :set_coupon, only: %i[create]
  def create
    @url = url_link
    if @coupon && Date.current <= @coupon.valid_til || @coupon.nil?
      @temp = Stripe::Coupon.create(percent_off: @coupon.value * 100, duration: 'once') if @coupon
      @session = stripe_session
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = 'Coupon has expired'
      redirect_to cart_path(@current_cart)
    end
  end

  private

  def set_coupon
    @coupon = Coupon.find_by(name: params[:coupon_name])
  end

  def set_line_items
    @current_cart.line_items.map do |item|
      {
        name: item.product.name,
        amount: item.product.price.to_i * 100,
        currency: 'usd',
        quantity: item.quantity
      }
    end
  end

  def url_link
    if @coupon
      success_payment_orders_url(coupon: @coupon.value)
    else
      success_payment_orders_url
    end
  end

  def stripe_session
    Stripe::Checkout::Session.create({
                                       payment_method_types: ['card'],
                                       line_items: set_line_items,
                                       mode: 'payment',
                                       success_url: @url,
                                       cancel_url: cart_url(@current_cart.id),
                                       discounts: [{ coupon: @temp&.id }]
                                     })
  end
end
