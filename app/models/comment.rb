class Comment < ApplicationRecord
  belongs_to :beer
  belongs_to :user
end
