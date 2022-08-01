require 'csv'

class FoodCostsController < ApplicationController
  def output
    respond_to do |format|
      format.html
      format.csv do |_csv|
        send_data(FoodCost.csv_output_data, filename: 'food_costs.csv')
      end
    end
  end
end
