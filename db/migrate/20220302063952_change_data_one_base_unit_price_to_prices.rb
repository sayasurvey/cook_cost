class ChangeDataOneBaseUnitPriceToPrices < ActiveRecord::Migration[6.1]
  def up
    change_column :prices, :one_base_unit_price, :float
  end

  def down
    change_column :prices, :one_base_unit_price, :integer
  end
end
