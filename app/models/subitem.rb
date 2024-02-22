class Subitem < ApplicationRecord
  belongs_to :item
  validates :price, format: { with: /\A\d+(\.\d+)?\z/ }
end
