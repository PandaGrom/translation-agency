class Category < ApplicationRecord
	belongs_to :categorable, polymorphic: true
end