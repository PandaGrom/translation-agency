# frozen_string_literal: true

class Order < ApplicationRecord
  has_one :categories, as: :categorable, dependent: :destroy
  has_many :comments, dependent: :restrict_with_exception
  has_one :file, dependent: :destroy
end
