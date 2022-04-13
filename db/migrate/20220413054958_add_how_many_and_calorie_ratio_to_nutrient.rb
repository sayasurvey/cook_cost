class AddHowManyAndCalorieRatioToNutrient < ActiveRecord::Migration[6.1]
  def up
    add_column :nutrients, :calorie_ratio, :integer
    add_column :nutrients, :carbohydrate_ratio, :integer
    add_column :nutrients, :protein_ratio, :integer
    add_column :nutrients, :lipid_ratio, :integer
    add_column :nutrients, :dietary_fiber_ratio, :integer
    add_column :nutrients, :salt_equivalent_ratio, :integer
    add_column :nutrients, :how_many, :string
  end

  def down
    remove_column :nutrients, :calorie_ratio, :integer
    remove_column :nutrients, :carbohydrate_ratio, :integer
    remove_column :nutrients, :protein_ratio, :integer
    remove_column :nutrients, :lipid_ratio, :integer
    remove_column :nutrients, :dietary_fiber_ratio, :integer
    remove_column :nutrients, :salt_equivalent_ratio, :integer
    remove_column :nutrients, :how_many, :string
  end
end
