class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :subitem, optional: true
  belongs_to :order
end
