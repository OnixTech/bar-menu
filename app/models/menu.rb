class Menu < ApplicationRecord
  belongs_to :company
  has_many :items, dependent: :delete_all
end
