class AddFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :files do |t|
      t.string :title
      t.references :order, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
