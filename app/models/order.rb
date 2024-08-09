class Order < ApplicationRecord
  has_many :order_items, dependent: :delete_all
  has_many :order_histories
  validates :total, format: { with: /\A\d+(\.\d+)?\z/ }
end
