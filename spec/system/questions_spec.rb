require 'rails_helper'

RSpec.describe "質問投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @question_title = Faker::Lorem.sentence
    @question_content = Faker::Lorem.sentence
  end
  context '質問投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      visit new_user_session_path
      fill_in 'メールアドレス',  with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 質問投稿ページへのリンクがあることを確認する
      expect(page).to have_content('質問する')
      # 質問投稿ページに遷移する
      visit new_question_path
      # フォーム情報を入力する
      fill_in '題名',  with: @question_title
      fill_in '質問内容', with: @question_content
      # 送信するとQuestionモデルのカウントが１上がることの確認
      expect{
        find('input[name="commit"]').click
      }.to change { Question.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページに先程投稿した質問の題名があることの確認
      expect(page).to have_content(@question_title)
    end
  end

  context '質問投稿ができないとき' do
    it 'ログインいていないと質問投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 質問投稿ページヘのリンクがない
      expect(page).to have_no_content('質問する')
    end
  end
end



