class Order < ApplicationRecord
  belongs_to :user

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  def self.search(search)
    if search
      order = Order.find_by(title: search)
        if order
          self.where(id: order)
        else
          @orders = Order.all
        end
      else
        @orders = Order.all
      end
  end
  
end
