class CreateIngredientLists < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredient_lists do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.float :calorie
      t.float :carbohydrate
      t.float :protein
      t.float :lipid
      t.float :dietary_fiber
      t.float :salt_equivalent

      t.timestamps
    end
    add_index :ingredient_lists, [:ingredient_id, :unit_id], unique: true
  end
end
