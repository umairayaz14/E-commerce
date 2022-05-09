class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  # GET /comments or /comments.json
  def index
    @product = Product.find(params[:product_id])
    @comments = @product.comments.all
    authorize @comments
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @product = Product.find(params[:product_id])
    @comment = Comment.new
    authorize @comment
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @product.user_id != @comment.user_id
      authorize @comment
      respond_to do |format|
        if @comment.save
          format.js
        else
          format.html { render :new }
        end
      end
    else
      flash[:alert] = 'User can not comment on his product!'
      redirect_to product_comments_path
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to product_comments_path, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to product_comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @product = Product.find(params[:product_id])
      @comment = @product.comments.find(params[:id])
      authorize @comment
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:name, :description)
    end
end
