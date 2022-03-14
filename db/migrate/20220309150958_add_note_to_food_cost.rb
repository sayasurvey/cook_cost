class AddNoteToFoodCost < ActiveRecord::Migration[6.1]
  def change
    add_column :food_costs, :note, :string
  end
end
