class CreateNutrients < ActiveRecord::Migration[6.1]
  def change
    create_table :nutrients do |t|
      t.references :recipe, null: false, foreign_key: true, unique: true
      t.integer :calorie
      t.integer :carbohydrate
      t.integer :protein
      t.integer :lipid
      t.float :dietary_fiber
      t.float :salt_equivalent

      t.timestamps
    end
  end
end
