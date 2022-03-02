class CreateIngredientUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredient_units do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.integer :ratio

      t.timestamps
    end
  end
end
