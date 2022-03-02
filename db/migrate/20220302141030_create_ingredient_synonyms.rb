class CreateIngredientSynonyms < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredient_synonyms do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :synonym, null: false, foreign_key: true

      t.timestamps
    end
  end
end
