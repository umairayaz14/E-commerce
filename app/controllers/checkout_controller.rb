class CheckoutController < ApplicationController

  def create
    # xyz = " "
    # current_cart.line_items.each do |li|
    # xyz += " #{li.product.name}\n"
    # end

  #   [{
  #     name: xyz,
  #     amount: current_cart.sub_total.truncate * 100,
  #     currency: "usd",
  #     quantity: current_cart.total_quantity
  # }]
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
