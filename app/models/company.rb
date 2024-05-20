class Company < ApplicationRecord
  belongs_to :user
  has_many :menus
  has_many :items, through: :menus
  has_many :subitems, through: :items
  has_many :stations, dependent: :delete_all
end
