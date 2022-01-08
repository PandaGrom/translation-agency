class AddColumnPricingToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :pricing, :decimal
  end
end
