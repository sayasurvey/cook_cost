class Unit < ApplicationRecord
  has_many :ingredient_units, dependent: :destroy
  has_many :prices, dependent: :destroy
  has_many :ingredient_lists, dependent: :destroy

  validates :unit, presence: true
end
