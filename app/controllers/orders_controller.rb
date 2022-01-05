class OrdersController < ApplicationController
  after_action :set, only: [:create]
  def index
    @orders = Order.search(params[:search])
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @categories = Category.all.pluck(:title)
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to orders_path(@order)
    else
      render :new
    end
  end

  private

  def set
    category = Category.find(params['order']['category_id'])
    @order.category = category
  end

  def order_params
    params.require(:order).permit(:title, :description)
  end
end
