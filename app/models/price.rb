class Price < ApplicationRecord
  has_many :food_costs, dependent: :destroy
  belongs_to :ingredient
  belongs_to :unit

  validates :ingredient_id, uniqueness: { scope: :unit_id}, presence: true
  validates :unit_id, presence: true
  validates :purchase_price, presence: true
  validates :quantity, presence: true
  validates :one_base_unit_price, presence: true
end
