class ChangeDataQuantityToPrice < ActiveRecord::Migration[6.1]
  def up
    change_column :prices, :quantity, :float
  end

  def down
    change_column :prices, :quantity, :integer
  end
end
