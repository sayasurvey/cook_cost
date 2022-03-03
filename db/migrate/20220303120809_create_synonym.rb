class CreateSynonym < ActiveRecord::Migration[6.1]
  def change
    create_table :synonyms do |t|
      t.references :ingredient, null: false, foreign_key: :true
      t.string :name, null: false

      t.timestamps
    end
  end
end
