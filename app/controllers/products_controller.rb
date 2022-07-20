# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit show update destroy]
  before_action :authenticate_user!, except: %i[index show]
  def index
    @products = Product.all
    authorize @products
    query = params[:query]
    @products = @products.where("name ILIKE '%#{query}%'") if query.present?
  end

  def new
    @product = Product.new
    authorize @product
  end

  def show
    @comment = Comment.new
  end

  def create
    @product = current_user.products.new(product_params)
    authorize @product
    if @product.save
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: 'Product was successfully destroyed.'
    else
      flash[:warning] = 'Unable to destroy Product.'
    end
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def edit; end

  private

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, images: [])
  end
end
