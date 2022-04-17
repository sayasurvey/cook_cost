require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create :user }

  describe 'ログイン画面' do
    it 'ログインができること' do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      expect(current_path).not_to eq(login_path)
      expect(page).to have_content('ログインに成功しました')
      expect(current_path).to eq(root_path)
    end

    it 'パスワードが違う場合はログインできないこと' do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'pass'
      click_button 'ログイン'
      expect(current_path).to eq(login_path)
      expect(page).to have_content('ログインに失敗しました')
    end
  end

  describe 'ログアウト' do
    it 'ログアウト' do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      expect(page).to have_content('ログインに成功しました')
      expect(current_path).to eq(root_path)
      find('.menu-btn').click
      binding.irb
      click_link 'ログアウト'
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ログアウトしました')
    end
  end
end
