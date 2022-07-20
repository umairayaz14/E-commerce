# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[create]
  before_action :set_comment, only: %i[edit update destroy]
  before_action :authorize_comment, only: %i[edit update destroy]

  def edit; end

  def create
    authorize @product, policy_class: CommentPolicy
    @comment = @product.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        flash.now[:notice] = 'Commented successfully'
      else
        flash.now[:alert] = 'unable to post a comment.'
      end
      format.js
    end
  end

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

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_comment
    @comment = set_product.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:name, :description).tap do |params|
      params[:user_id] = current_user.id
    end
  end

  def authorize_comment
    authorize @comment
  end
end
