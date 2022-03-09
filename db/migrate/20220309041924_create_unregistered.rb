class CreateUnregistered < ActiveRecord::Migration[6.1]
  def change
    create_table :unregistereds do |t|
      t.string :url, null: false
      t.string :ingredient, null: false
      t.string :amount, null: false

      t.timestamps
    end
  end
end
