# frozen_string_literal: true

class AddOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :title
      t.integer :cost
      # t.boolean :status, default: false
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
