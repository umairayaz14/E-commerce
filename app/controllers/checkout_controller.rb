# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def create
    line_items = current_cart.line_items.map do |item|
      {
        name: item.product.name,
        amount: item.product.price.to_i * 100,
        currency: 'usd',
        quantity: item.quantity
      }
    end

    @coupon = Coupon.find_by(name: params[:coupon_name])
    url = if @coupon
            final_order_url(coupon: @coupon.value)
          else
            final_order_url
          end

    if @coupon && Date.current <= @coupon.valid_til || @coupon.nil?
      @temp = Stripe::Coupon.create(percent_off: @coupon.value * 100, duration: 'once') if @coupon
      @session = Stripe::Checkout::Session.create({
                                                    payment_method_types: ['card'],
                                                    line_items: line_items,
                                                    mode: 'payment',
                                                    success_url: url,
                                                    cancel_url: cart_url(current_cart.id),
                                                    discounts: [{ coupon: @temp&.id }]
                                                  })

      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = 'Coupon has expired'
      redirect_to cart_path(current_cart)
    end
  end
end
