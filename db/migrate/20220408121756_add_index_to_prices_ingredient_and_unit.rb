class AddIndexToPricesIngredientAndUnit < ActiveRecord::Migration[6.1]
  def up
    add_index :prices, [:ingredient_id, :unit_id], unique: true
  end

  def down
    remove_index :prices, [:ingredient_id, :unit_id], unique: true
  end
end
