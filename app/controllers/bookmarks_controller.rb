class BookmarksController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @bookmark = @recipe.bookmarks.new(user_id: current_user.id)
    redirect_to request.referer unless @bookmark.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @bookmark = @recipe.bookmarks.find_by(user_id: current_user.id)
    if @bookmark.present?
      @bookmark.destroy
    else
      redirect_to request.referer
    end
  end
end
