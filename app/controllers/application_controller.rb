class ApplicationController < ActionController::Base
  include RakutenRecipeScrapes

  def set_recipe_information
    @recipe_information = []
  end
end
