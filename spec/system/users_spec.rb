require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザーが新規登録できてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報入力する
      fill_in 'ユーザー名(必須)',  with: @user.nickname
      fill_in '電話番号(必須)',   with: @user.phone_number
      fill_in 'メールアドレス(必須)', with: @user.email
      fill_in 'パスワード(必須)', with: @user.password
      fill_in 'パスワード再入力(必須)', with: @user.password_confirmation
      # 新規登録ボタンを押すとユーザーモデルのカウントが１上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページにログアウトや質問のボタンがあることを確認する。
      expect(page).to have_content('ログアウト')
      expect(page).to have_content('質問する')
      # 新規登録やログインのボタンがないことの確認
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('新規登録')
    # 新規登録ページへ移動する
    visit new_user_registration_path
    # ユーザー情報入力する
    fill_in 'ユーザー名(必須)',  with: ''
    fill_in '電話番号(必須)',   with: ''
    fill_in 'メールアドレス(必須)', with: ''
    fill_in 'パスワード(必須)', with: ''
    fill_in 'パスワード再入力(必須)', with: ''
    # 新規登録ボタンを押すとユーザーモデルのカウントが上がらないことを確認する
    expect  do
      find('input[name="commit"]').click
    end.to change { User.count }.by(0)
    # 新規登録ページへ戻されることを確認する
    expect(current_path).to eq '/users'
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインできるとき' do
    it '保存されているユーザー情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # トップページにログアウトや質問のボタンがあることを確認する。
      expect(page).to have_content('ログアウト')
      expect(page).to have_content('質問する')
      # 新規登録やログインのボタンがないことの確認
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  it '保存されているユーザーの情報が合致しないとログインができない' do
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('ログイン')
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいユーザー情報を入力する
    fill_in 'メールアドレス', with: ''
    fill_in 'パスワード', with: ''
    # ログインボタンを押す
    find('input[name="commit"]').click
    # ログインページへ戻されることを確認する
    expect(current_path).to eq new_user_session_path
  end
end
