class CreateChildCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :child_categories do |t|
      t.references :category
      t.string :name
      t.integer :rakuten_id

      t.timestamps
    end
  end
end
