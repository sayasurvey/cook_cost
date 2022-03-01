class Ingredient < ApplicationRecord
  validates :name, presence: true
  validates :base_unit, numericality: { in: 1..2 }
end
