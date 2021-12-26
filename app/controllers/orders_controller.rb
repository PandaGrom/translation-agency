class OrdersController < ApplicationController
  def index
    @orders = Order.search(params[:search])
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @order = Order.new
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
  def order_params
    params.require(:order).permit(:title, :description)
  end
  
end