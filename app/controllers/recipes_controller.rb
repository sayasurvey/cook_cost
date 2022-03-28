class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.left_outer_joins(:food_costs)
                     .group("recipes.id")
                     .select("recipes.*, sum(food_costs.cost) as cook_cost")
                     .order("recipes.created_at DESC")
                     .page(params[:page])
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @food_costs = FoodCost.where(recipe_id: params[:id])
                          .joins(price: :ingredient)
                          .select("ingredients.name, prices.purchase_price, prices.quantity, prices.unit_id, food_costs.id, food_costs.quantity_unit, food_costs.cost, food_costs.note")
                          .order(id: :asc)
    @cost_sum = @food_costs.sum(:cost)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  def about; end

  def bookmarks
    @recipes = current_user.bookmark_recipes
                           .left_outer_joins(:food_costs)
                           .group("recipes.id")
                           .select("recipes.*, sum(food_costs.cost) as cook_cost")
                           .order("recipes.created_at DESC")
                           .page(params[:page])
  end

  def scrape
    if params[:url].match(/([https:\/\/recipe.rakuten.co.jp\/recipe\/]+[0-9]{10}\/)/)
      scrape_rakuten_recipes(params[:url])
      redirect_to recipe_path(Recipe.find_by(recipe_url: params[:url]))
    else
      flash.now['danger'] = '無効なURLです'
      render :about
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
end
