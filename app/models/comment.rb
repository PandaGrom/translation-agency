class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_many :replies, dependent: :delete_all
end
