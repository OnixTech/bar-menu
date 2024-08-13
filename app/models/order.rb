class Order < ApplicationRecord
  has_many :order_items, dependent: :delete_all
  has_many :order_histories
  belongs_to :station
  validates :total, format: { with: /\A\d+(\.\d+)?\z/ }
end
