class UpdateOrder
  def initialize(order_id, action_type)
    @order_id = order_id
    @action_type = action_type
  end

  def call
    order = Order.find(@order_id)
    order.public_send(@action_type)
    order.save!
  end
end
