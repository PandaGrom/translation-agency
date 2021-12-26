class Order < ApplicationRecord
  belongs_to :user

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
  
    include AASM
  
    aasm do # default column: aasm_state
      state :on_consider, initial: true
      state :in_progress
      state :completed
  
      event :take do
        transitions from: :on_consider, to: :in_progress
      end
  
      event :complete do
        transitions from: :in_progress, to: :completed
      end
    end
  
end
