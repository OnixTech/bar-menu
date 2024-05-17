class Company < ApplicationRecord
  belongs_to :user
  has_many :menus
  has_many :stations, dependent: :delete_all
end
