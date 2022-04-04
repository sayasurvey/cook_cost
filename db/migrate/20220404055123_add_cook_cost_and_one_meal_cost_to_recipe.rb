class AddCookCostAndOneMealCostToRecipe < ActiveRecord::Migration[6.1]
  def up
    add_column :recipes, :cook_cost, :integer
    add_column :recipes, :one_meal_cost, :integer
  end

  def down
    remove_column :recipes, :cook_cost, :integer
    remove_column :recipes, :one_meal_cost, :integer
  end
end
