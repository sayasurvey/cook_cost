class Synonym < ApplicationRecord
  has_one :ingredient_synonym

  validates :name, presence: true
end
