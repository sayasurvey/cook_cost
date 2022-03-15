class Recipe < ApplicationRecord
  has_many :food_costs, dependent: :destroy
  validates :recipe_url, presence: true, format: { with: /([https:\/\/recipe.rakuten.co.jp\/recipe\/]+[0-9]{10}\/)/ }
end
