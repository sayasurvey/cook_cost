class IngredientUnit < ApplicationRecord
  belongs_to :ingredient
  belongs_to :unit

  validates :ingredient_id, uniqueness: { scope: :unit_id}, presence: true
  validates :unit_id, presence: true
  validates :ratio, presence: true
end
