class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :show, :update, :destroy]
  # GET /products or /products.json
  def index
    @products = Product.all
    authorize @products
  end

  def new
    @product = Product.new
    authorize @product
  end

  def show
    @comment = @product.comments.build
    @comment.user_id = current_user.id if current_user.present?
  end
  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
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

  def edit
  end

  private
    def set_product
      @product = Product.find(params[:id])
      authorize @product
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :quantity, images: [])
    end
end
