class CalculateFileReport
  require 'open-uri'

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(order_id)
    @order = Order.find(order_id)

    analyze_report(@order)
  end

  def analyze_report(order)
    order.file.blob.open do |file|
      @content = file.read
    end

    OrderFileReport.create(
      order: order,
      symbols_count: @content.length,
      words_count: @content.split.count,
      symbols_exlude_spaces_count: @content.split.join.length
    )
  end
end
