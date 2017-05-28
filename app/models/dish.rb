class Dish < ApplicationRecord
  belongs_to :restaurant
  validates :dish, :price, presence: true
end
