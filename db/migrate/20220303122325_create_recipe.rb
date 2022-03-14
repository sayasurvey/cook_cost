class CreateRecipe < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :recipe_url, null: false
      t.string :cuisine_name, null: false
      t.string :originator, null: false

      t.timestamps
    end
  end
end
