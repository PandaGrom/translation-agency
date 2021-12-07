class File < ApplicationRecord
  has_one :report
  belongs_to :order
  has_one :categories, as: :categorable
end