class Ingredient < ApplicationRecord
  has_many :ingredient_units
  has_many :prices
  has_many :synonyms

  validates :name, presence: true
  validates :base_unit, presence: true
end
