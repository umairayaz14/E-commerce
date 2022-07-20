# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit show update destroy]
  before_action :authenticate_user!, except: %i[index show]
  #before_action
  # GET /products or /products.json
  def index
    @products = Product.all
    authorize @products
    # authorize Product

    query = params[:query]
    @products = @products.where("name ILIKE '%#{query}%'") if query.present?
  end

  def new
    @product = Product.new
    authorize @product
  end

  def show
    # @comment = @product.comments.build
    @comment = Comment.new
    # @comment.user_id = current_user.id if current_user.present?
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.new(product_params)
    authorize @product
    if @product.save
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # DELETE /products/1 or /products/1.json
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

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, images: [])
  end

  # def autoriztion
  #   authorize Product
  # end
end
