class CreatePrice < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.integer :purchase_price, null: false
      t.integer :quantity, null: false
      t.references :unit, null: false, foreign_key: true
      t.float :one_base_unit_price, null: true

      t.timestamps
    end
  end
end
