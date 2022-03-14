class CreateIngredientUnit < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredient_units do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.float :ratio, null: false

      t.timestamps
    end
  end
end
