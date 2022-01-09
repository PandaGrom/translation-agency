class OrdersController < ApplicationController
  before_action :find_category, only: [:create]
  def index
    authorize Order
    @orders = if current_user.role == 'user'
                current_user.orders.order(:created_at)
              else
                Order.search(params[:search]).order(:created_at)
              end
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
    @comment = @order.comments.build
    @comments = Comment.where(order_id: @order.id).order(created_at: :desc)
  end

  def new
    authorize Order
    @order = Order.new
    @categories = Category.all.pluck(:title)
  end

  def create
    authorize Order
    @order = Order.new(order_params)
    @order.user = current_user
    @order.category = new_category

    if @order.save
      redirect_to orders_path(@order)
      CalculateFileReport.perform_async(@order.id)
    else
      render :new
    end
  end

  def export_csv_file
    csv = GenerateCsv.new(params[:id]).call

    send_data csv[:report], filename: csv[:filename]
  end

  def update
    UpdateOrder.new(params[:id], params[:action_type]).call
    redirect_to orders_path
  end

  def destroy
    @order = Order.find(params[:id])
    authorize @order
    @order.destroy
    flash[:success] = 'Order deleted'
    redirect_to orders_path
  end

  private

  def new_category
    Category.create(title: @category.title)
  end

  def find_category
    @category = Category.find(params['order']['category_id'])
  end

  def order_params
    params.require(:order).permit(:title, :description, :file, :deadline)
  end
end
