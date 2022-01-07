class OrdersController < ApplicationController
  before_action :find_category, only: [:create]
  def index
    @orders = if current_user.role == 'user'
                current_user.orders
              else
                Order.search(params[:search])
              end
  end

  def show
    @order = Order.find(params[:id])
    @comment = @order.comments.build
    @comments = Comment.where(order_id: @order.id)
  end

  def new
    @order = Order.new
    @categories = Category.all.pluck(:title)
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.category = @category
    if @order.save
      redirect_to orders_path(@order)
    else
      render :new
    end
  end

  private

  def find_category
    @category = Category.find(params['order']['category_id'])
  end

  def order_params
    params.require(:order).permit(:title, :description, :file, :deadline)
  end
end
