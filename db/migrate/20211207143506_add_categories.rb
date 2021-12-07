# frozen_string_literal: true

class AddCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.timestamps
    end
  end
end
