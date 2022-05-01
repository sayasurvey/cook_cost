class IngredientList < ApplicationRecord
  belongs_to :ingredient
  belongs_to :unit
end
