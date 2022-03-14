class AddHowManyToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :how_many, :string
  end
end
