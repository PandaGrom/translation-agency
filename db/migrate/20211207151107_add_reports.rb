# frozen_string_literal: true

class AddReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :file, null: false, foreign_key: true
      t.timestamps
    end
  end
end
