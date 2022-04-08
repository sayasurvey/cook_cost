class AddIndexToIngredientUnitUserIdAndRecipeId < ActiveRecord::Migration[6.1]
  def up
    add_index :ingredient_units, [:ingredient_id, :unit_id], unique: true
  end

  def down
    remove_index :ingredient_units, [:ingredient_id, :unit_id], unique: true
  end
end
