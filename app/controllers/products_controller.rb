class ProductsController < ApplicationController

  # GET /products or /products.json
  def index
    @products = Product.all
    @product = Product.new
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.create(product_params)
    redirect_to products_path
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    if user_signed_in?
      @product = Product.find(params[:id])
      if current_user.id == @product.user_id
        @product.destroy
        redirect_to products_path, notice: 'Product deleted successfully!'
      else
        redirect_to products_path, notice: 'Not authorised to delete product!'
      end
    else
      redirect_to products_path, notice: 'Not authorised to delete product!!'
    end
  end

  def update
    @product = current_user.products.find(params[:id])
    @product.update(product_params)
    redirect_to products_path
  end

  def edit
    #@product = current_user.products.find(params[:id])

    if user_signed_in?
      @product = Product.find(params[:id])
    else
      redirect_to products_path, notice: 'Not authorised to update product!'
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, images: [])
    end
end
