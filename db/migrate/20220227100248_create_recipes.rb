class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :cookpad_url
      t.string :cuisine_name
      t.string :originator

      t.timestamps
    end
  end
end
