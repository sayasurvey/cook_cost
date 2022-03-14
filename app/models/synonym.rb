class Synonym < ApplicationRecord
  belongs_to :ingredient

  validates :name, presence: true
  validates :ingredient, presence: true
end
