class Unit < ApplicationRecord
  has_many :ingredient_units, dependent: :destroy
  has_many :prices, dependent: :destroy

  validates :unit, presence: true
end
