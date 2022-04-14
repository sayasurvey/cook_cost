class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show]
  before_action :require_login, only: %i[bookmarks]

  # GET /recipes or /recipes.json
  def index
    @q = Recipe.order('recipes.created_at DESC').ransack(params[:q])
    @recipes = @q.result(distinct: true).page(params[:page])
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @food_costs = FoodCost.where(recipe_id: params[:id])
                          .joins(price: :ingredient)
                          .select('ingredients.name,
                                   prices.purchase_price,
                                   prices.quantity,
                                   prices.unit_id,
                                   food_costs.id,
                                   food_costs.quantity_unit,
                                   food_costs.cost,
                                   food_costs.note')
                          .order(id: :asc)
    @cost_sum = @food_costs.sum(:cost)
    #@nutrient = Nutrient.find_by(recipe_id: params[:id])
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  def about; end

  def bookmarks
    @q = current_user.bookmark_recipes
                     .order('recipes.created_at DESC')
                     .ransack(params[:q])
    @recipes = @q.result(distinct: true).page(params[:page])
  end

  def scrape
    if params[:url].match(%r{([https://recipe.rakuten.co.jp/recipe/]+[0-9]{10}/)})
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
