class Nutrient < ApplicationRecord
  belongs_to :recipe

  validates :recipe_id, uniqueness: true, presence: true
end