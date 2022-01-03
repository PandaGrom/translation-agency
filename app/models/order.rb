class Order < ApplicationRecord
  belongs_to :user

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  has_one :category, as: :categorable

  def self.search(query)
    return Order.all unless query

    where(title: query)
  end
end
