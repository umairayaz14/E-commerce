class OrdersController < ApplicationController

  before_action :authenticate_user!
  def index
  end

  def create
    @order = Order.new
    current_cart.line_items.each do |item|
      @order.line_items << item
      # @order.line_items.each do |ord|
      #   ord.product_id = item.product_id
      #   ord.cart_id = item.cart_id
      #   ord.quantity = item.cart_id
      # end
      # @order.line_items.new(
      #   product_id: item.product_id,
      #   cart_id: item.cart_id,
      #   quantity: item.cart_id
      # )
      item.cart_id = nil
    end
    @order.quantity = current_cart.total_quantity
    @order.total = current_cart.sub_total
    @order.user_id = current_user.id
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to orders_path
    else
      flash[:warning] = "Order could not be saved"
    end
  end

  private
    def order_params
      params.require(:order).permit(:cart_id, :user_id)
    end

end
