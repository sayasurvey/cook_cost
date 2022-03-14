require 'rails_helper'

RSpec.describe "Recipes", type: :system do
  describe '材料費の計算' do
    it '複雑でない材料名の計算' do
      visit root_path
      fill_in 'url', with: 'https://recipe.rakuten.co.jp/recipe/1190004346/'
      find('.url-btn').click
      expect(page).to have_content('ごはん')
      expect(page).to have_content('34.0')
      expect(page).to have_content('鶏もも肉')
      expect(page).to have_content('462.3')
      expect(page).to have_content('玉ねぎ')
      expect(page).to have_content('78.0')
      expect(page).to have_content('卵')
      expect(page).to have_content('63.9')
      expect(page).to have_content('酒')
      expect(page).to have_content('7.1')
      expect(page).to have_content('小松菜')
      expect(page).to have_content('35.3')
      expect(page).to have_content('めんつゆ')
      expect(page).to have_content('6.8')
      expect(page).to have_content('みりん')
      expect(page).to have_content('9.1')
      expect(page).to have_content('さとう')
      expect(page).to have_content('1.8')
      expect(page).to have_content('しょうゆ')
      expect(page).to have_content('5.8')
    end
  end
end
