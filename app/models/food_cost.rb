class FoodCost < ApplicationRecord
  belongs_to :price
  belongs_to :recipe

  def self.csv_output_data
    food_costs = self.all
    csv_data = CSV.generate do |csv|
      header = %w[id recipe_id price_id quantity_unit cost note]
      csv << header
      food_costs.each do |food_cost|
        values = [food_cost.id, food_cost.recipe_id, food_cost.price_id, food_cost.quantity_unit, food_cost.cost,
                  food_cost.note]
        csv << values
      end
    end
  end
end
