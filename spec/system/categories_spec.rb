require 'rails_helper'

RSpec.describe "Categories", type: :system do
  describe 'カテゴリー' do
    it 'カテゴリー一覧からレシピを選択' do
      visit root_path
      page.all('.btn-rakuten')[1].click
      page.all('.category-btn')[0].click
      page.all('.category-btn')[0].click
      page.all('.btn .width-100')[0].click
      expect(page).to have_content('https://recipe.rakuten.co.jp/recipe/1590002716/')
    end
  end
end
