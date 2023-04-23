class Item < ApplicationRecord
  belongs_to :menu
  validates :price, :position, format: { with: /\A\d+(\.\d+)?\z/ }
end
