class CreateOrderFileReports < ActiveRecord::Migration[6.1]
  def change
    create_table :order_file_reports do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :symbols_count, null: false
      t.integer :words_count, null: false
      t.integer :symbols_exlude_spaces_count, null: false

      t.timestamps
    end
  end
end
