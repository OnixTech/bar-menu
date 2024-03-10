class Subitem < ApplicationRecord
  belongs_to :item
  has_many :order_items, dependent: :delete_all
  validates :price, format: { with: /\A\d+(\.\d+)?\z/ }
end
