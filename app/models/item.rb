class Item < ApplicationRecord
  belongs_to :menu
  has_many :order_items, dependent: :delete_all
  has_many :subitems, dependent: :delete_all
  validates :price, :position, format: { with: /\A\d+(\.\d+)?\z/ }
end
