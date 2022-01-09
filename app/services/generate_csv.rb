require 'csv'
class GenerateCsv
  def initialize(order_id)
    @order_id = order_id
  end

  def call
    order = Order.find(@order_id)
    report = order.order_file_report
    csv_report = CSV.generate do |csv|
      csv << ['order title', 'symbols count', 'words count', 'symbols exclude spaces count']
      csv << [order.title, report.symbols_count, report.words_count, report.symbols_exlude_spaces_count]
    end

    { report: csv_report, filename: "order #{order.title} file report.csv" }
  end
end
