require 'csv'

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
    @comments = Comment.where(order_id: @order.id).order(created_at: :desc)
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_path
  end

  def new
    @order = Order.new
    @categories = Category.all.pluck(:title)
  end

  def create
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
    @order = Order.find(params[:id])
    @report = @order.order_file_report

    csv_report = CSV.generate do |csv|
      csv << ['order title', 'symbols count', 'words count', 'symbols exclude spaces count']
      csv << [@order.title, @report.symbols_count, @report.words_count, @report.symbols_exlude_spaces_count]
    end

    send_data csv_report, filename: "order '#{@order.title}' file report.csv"
  end

  def take
    change_aasm_state(:take)
  end

  def close
    change_aasm_state(:complete)
  end

  def open
    change_aasm_state(:cancel)
  end

  private

  def new_category
    Category.create(title: @category.title)
  end

  def change_aasm_state(method)
    @order = Order.find(params[:id])
    @order.send(method)
    @order.save!
    redirect_to orders_path
  end

  def find_category
    @category = Category.find(params['order']['category_id'])
  end

  def order_params
    params.require(:order).permit(:title, :description, :file, :deadline)
  end
end
