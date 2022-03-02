class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.integer :purchase_price
      t.integer :quantity
      t.references :unit, null: false, foreign_key: true
      t.integer :one_base_unit_price

      t.timestamps
    end
  end
end
