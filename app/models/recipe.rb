class Recipe < ApplicationRecord
  has_many :food_costs, dependent: :destroy
end
