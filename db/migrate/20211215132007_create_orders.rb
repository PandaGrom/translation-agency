class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :title
      t.decimal :cost, default: '0.0'
      t.integer :status, default: 0
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
