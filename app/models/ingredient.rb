class Ingredient < ApplicationRecord
  has_many :ingredient_units, dependent: :destroy
  has_many :prices, dependent: :destroy
  has_many :synonyms, dependent: :destroy

  validates :name, presence: true
  validates :base_unit, presence: true
end
