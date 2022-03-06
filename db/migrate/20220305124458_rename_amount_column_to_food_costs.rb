class RenameAmountColumnToFoodCosts < ActiveRecord::Migration[6.1]
  def up
    rename_column :food_costs, :amount, :quantity_unit
  end

  def down
    rename_column :food_costs, :quantity_unit, :amount
  end
end
