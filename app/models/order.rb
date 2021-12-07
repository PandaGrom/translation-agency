class Order < ApplicationRecord
	has_one :categories, as: :categorable
	has_many :comments
	has_one :file
end