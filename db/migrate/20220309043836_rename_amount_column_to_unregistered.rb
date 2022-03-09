class RenameAmountColumnToUnregistered < ActiveRecord::Migration[6.1]
  def up
    rename_column :unregistereds, :amount, :quantity
  end

  def down
    rename_column :unregistereds, :quantity, :amount
  end
end
