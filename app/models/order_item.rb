class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :subitem
  belongs_to :order
end
