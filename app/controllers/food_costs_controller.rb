require 'csv'

class FoodCostsController < ApplicationController
  def output
    respond_to do |format|
      format.html
      format.csv do |_csv|
        food_costs = FoodCost.all
        csv_data = CSV.generate do |csv|
          header = %w[id recipe_id price_id quantity_unit cost note]
          csv << header
          food_costs.each do |food_cost|
            values = [food_cost.id, food_cost.recipe_id, food_cost.price_id, food_cost.quantity_unit, food_cost.cost,
                      food_cost.note]
            csv << values
          end
        end
        send_data(csv_data, filename: 'food_costs.csv')
      end
    end
  end
end
