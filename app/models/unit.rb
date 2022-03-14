class Unit < ApplicationRecord
  has_many :ingredient_units
  has_many :prices

  validates :unit, presence: true
end
