class Order < ApplicationRecord
  belongs_to :user

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
  has_one :category, as: :categorable
end
