class AddNoteToNutrient < ActiveRecord::Migration[6.1]
  def change
    add_column :nutrients, :note, :string
  end
end
