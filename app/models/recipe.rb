class Recipe < ApplicationRecord
  has_many :food_costs, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_recipes, through: :bookmarks, source: :recipe
  has_one :nutrient, dependent: :destroy

  validates :recipe_url, presence: true, format: { with: %r{([https://recipe.rakuten.co.jp/recipe/]+[0-9]{10}/)} }

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end
