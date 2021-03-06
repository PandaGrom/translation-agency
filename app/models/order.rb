class Order < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  has_one :order_file_report, dependent: :delete
  has_many :comments, dependent: :delete_all

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  include AASM

  aasm do # default column: aasm_state
    state :open, initial: true
    state :in_progress
    state :completed

    event :take do
      transitions from: :open, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed
    end

    event :cancel do
      transitions from: :in_progress, to: :open
    end
  end

  has_one :category, as: :categorable

  def self.search(query)
    return Order.all if query.blank?

    where('title ILIKE ?', "#{query}%")
  end
end
