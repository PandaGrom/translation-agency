class Drop < ActiveRecord::Migration[6.1]
  def change
    drop_table :categories, force: :cascade
    drop_table :reports, force: :cascade
    drop_table :comments, force: :cascade
    drop_table :files, force: :cascade
  end
end
