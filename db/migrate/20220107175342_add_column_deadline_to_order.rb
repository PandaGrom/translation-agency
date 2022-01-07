class AddColumnDeadlineToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :deadline, :datetime
  end
end
