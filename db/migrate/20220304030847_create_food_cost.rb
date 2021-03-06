class CreateFoodCost < ActiveRecord::Migration[6.1]
  def change
    create_table :food_costs do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :price, null: false, foreign_key: true
      t.float :amount
      t.float :cost

      t.timestamps
    end
  end
end
