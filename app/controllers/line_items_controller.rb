# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :current_cart
  before_action :set_product, only: %i[create]

  def create
    if @current_cart.products.include?(@chosen_product)
      @line_item = @current_cart.line_items.find_by(product_id: @chosen_product)
      @line_item.quantity += 1 if @line_item.quantity < @line_item.product.quantity
    else
      @line_item = LineItem.new
      @line_item.cart = @current_cart
      @line_item.product = @chosen_product
    end

    @line_item.save
    redirect_to cart_path(@current_cart)
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    if @line_item.destroy
      redirect_to cart_path(@current_cart), notice: 'Product was successfully destroyed.'
    else
      flash[:warning] = 'Unable to destroy Product.'
    end
  end

  def add_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity < @line_item.product.quantity
      @line_item.quantity += 1
      @line_item.save
    else
      flash[:alert] = 'Product out of stock!'
    end
    redirect_to cart_path(@current_cart)
  end

  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity -= 1 if @line_item.quantity > 1
    @line_item.save
    redirect_to cart_path(@current_cart)
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity, :product_id, :cart_id)
  end

  def set_product
    @chosen_product = Product.find(params[:product_id])
  end
end
