class CommentsController < ApplicationController
  before_action :find_order, only: %i[destroy create]
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def destroy
    @comment = @order.comments.find(params[:id])

    @comment.destroy
    flash[:success] = 'Comment deleted'
    redirect_to order_path(@order)
  end

  def create
    @comment = @order.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  private

  def find_order
    @order = Order.find(params['order_id'])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
