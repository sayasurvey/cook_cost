class FoodCost < ApplicationRecord
  belongs_to :price
  belongs_to :recipe
end
