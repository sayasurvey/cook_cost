class IngredientSynonym < ApplicationRecord
  belongs_to :ingredient
  belongs_to :synonym

  validates :grocery_id, presence: true
  validates :synonym_id, presence: true
end
