class Ingredient < ApplicationRecord
  has_many :ingredient_units
  has_many :prices

  validates :name, presence: true
  validates :base_unit, numericality: { in: 1..2 }, presence: true
end
