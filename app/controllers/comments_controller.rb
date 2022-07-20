# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :set_product, only: %i[new create set_comment]
  before_action :authenticate_user!

  # GET /comments/new
  def new
    @comment = Comment.new
    authorize @omment
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments or /comments.json
  def create
    authorize @product, policy_class: CommentPolicy
    @comment = @product.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to product_path(@product), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to product_url(@product), notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      else
        flash[:alert] = 'Unable to destroy comment!'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_comment
    # @product = Product.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
    authorize @comment
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:name, :description).tap do |params|
      params[:user_id] = current_user.id
    end
  end
end
