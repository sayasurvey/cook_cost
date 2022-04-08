class AddIndexToBookmarksUserIdAndRecipeId < ActiveRecord::Migration[6.1]
  def up
    add_index :bookmarks, [:user_id, :recipe_id], unique: true
  end

  def down
    remove_index :bookmarks, [:user_id, :recipe_id], unique: true
  end
end
