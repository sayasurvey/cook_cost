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
    it '分量で分数あり' do
      visit root_path
      fill_in 'url', with: 'https://recipe.rakuten.co.jp/recipe/1090001352/'
      find('.url-btn').click
      expect(page).to have_content('豚肉')
      expect(page).to have_content('186')
      expect(page).to have_content('キャベツ')
      expect(page).to have_content('15.4')
      expect(page).to have_content('ピーマン')
      expect(page).to have_content('121.8')
      expect(page).to have_content('ネギ')
      expect(page).to have_content('4.0')
      expect(page).to have_content('にんにく')
      expect(page).to have_content('13.1')
      expect(page).to have_content('しょうが')
      expect(page).to have_content('0.9')
      expect(page).to have_content('味噌')
      expect(page).to have_content('22.3')
      expect(page).to have_content('さとう')
      expect(page).to have_content('1.8')
      expect(page).to have_content('しょうゆ')
      expect(page).to have_content('3.9')
      expect(page).to have_content('酒')
      expect(page).to have_content('3.5')
      expect(page).to have_content('ごま油')
      expect(page).to have_content('5.3')
      expect(page).to have_content('豆板醤')
      expect(page).to have_content('16.4')
    end
    it '分量で()あり' do
      visit root_path
      fill_in 'url', with: 'https://recipe.rakuten.co.jp/recipe/1760028309/'
      find('.url-btn').click
      expect(page).to have_content('鶏むね肉')
      expect(page).to have_content('195.0')
      expect(page).to have_content('塩')
      expect(page).to have_content('0.3')
      expect(page).to have_content('酒')
      expect(page).to have_content('3.5')
      expect(page).to have_content('片栗粉')
      expect(page).to have_content('12.2')
      expect(page).to have_content('塩')
      expect(page).to have_content('1.0')
      expect(page).to have_content('鶏がらスープの素')
      expect(page).to have_content('4.8')
      expect(page).to have_content('こしょう')
      expect(page).to have_content('2.7')
      expect(page).to have_content('長ネギ')
      expect(page).to have_content('212.0')
      expect(page).to have_content('いりごま')
      expect(page).to have_content('1.9')
      expect(page).to have_content('ごま油')
      expect(page).to have_content('7.9')
      expect(page).to have_content('水')
      expect(page).to have_content('0.0')
    end
  end
end
