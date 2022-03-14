class CreateIngredient < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :name, nill: false
      t.string :base_unit, nill: false

      t.timestamps
    end
  end
end
