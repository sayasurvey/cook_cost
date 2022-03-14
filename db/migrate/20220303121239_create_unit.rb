class CreateUnit < ActiveRecord::Migration[6.1]
  def change
    create_table :units do |t|
      t.string :unit, null: false

      t.timestamps
    end
  end
end
