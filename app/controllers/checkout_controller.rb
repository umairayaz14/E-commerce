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
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: final_order_url,
      cancel_url: cart_url(params[:cart_id])
    })

    respond_to do |format|
      format.js
    end
  end
end
