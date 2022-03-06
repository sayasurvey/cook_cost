class ChangeDataAmountToFoodCost < ActiveRecord::Migration[6.1]
  def up
    change_column :food_costs, :amount, :string
  end

  def down
    change_column :food_costs, :amount, :float
  end
end
