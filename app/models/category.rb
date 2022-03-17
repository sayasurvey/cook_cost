class Category < ApplicationRecord
  has_many :child_categories, dependent: :destroy
end
