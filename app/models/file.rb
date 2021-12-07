# frozen_string_literal: true

class File < ApplicationRecord
  has_one :report, dependent: :destroy
  belongs_to :order
  has_one :categories, as: :categorable, dependent: :destroy
end
