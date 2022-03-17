class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  
  def populer_menu; end

  def show
    @category = Category.find(params[:id])
    @child_categories = ChildCategory.where(category_id: params[:id])
  end
end
