require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe '確認観点1: ユーザーの新規登録' do
    it '1-1:ユーザーの登録' do
      visit new_user_path
      fill_in 'ニックネーム', with: 'user'
      fill_in 'メールアドレス', with: 'user@gmail.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード(確認用)', with: 'password'
      click_button '登録'
      expect(current_path).to eq('/login'), 'ユーザー作成後にログイン画面に遷移できていません'
      expect(page).to have_content('ログイン')
    end

    it '1-2:同じメールアドレスのユーザーは新規登録できない' do
      user = create(:user)
      visit new_user_path
      fill_in 'ニックネーム', with: user.name
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード(確認用)', with: 'password'
      click_button '登録'
      expect(current_path).to eq('/users'), 'ユーザー作成後にユーザー作成画面に戻ってません'
      expect(page).to have_content('ユーザー登録')
      expect(page).to have_content('ユーザーの作成に失敗しました')
    end

    it '1-3:入力項目が不足している場合に新規登録ができない' do
      visit new_user_path
      fill_in 'メールアドレス', with: 'user@gmail.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード(確認用)', with: 'password'
      click_button '登録'
      expect(current_path).to eq('/users'), 'ユーザー作成後にユーザー作成画面に戻ってません'
      expect(page).to have_content('ユーザー登録')
      expect(page).to have_content('ユーザーの作成に失敗しました')
    end

    it '1-4:パスワードが3文字未満の場合に新規登録できない' do
      visit new_user_path
      fill_in 'ニックネーム', with: 'user'
      fill_in 'メールアドレス', with: 'user@gmail.com'
      fill_in 'パスワード', with: 'pa'
      fill_in 'パスワード(確認用)', with: 'pa'
      click_button '登録'
      expect(current_path).to eq('/users'), 'ユーザー作成後にユーザー作成画面に戻ってません'
      expect(page).to have_content('ユーザー登録')
      expect(page).to have_content('ユーザーの作成に失敗しました')
    end
  end
end
