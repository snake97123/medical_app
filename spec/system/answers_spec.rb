require 'rails_helper'

RSpec.describe "回答投稿", type: :system do
    before do
      @question1 = FactoryBot.create(:question)
      @question2 = FactoryBot.create(:question)
      @answer_text =  Faker::Lorem.sentence
    end
    context '質問回答ができるとき' do
    it 'ログインしたユーザーは自分が投稿した以外の質問に回答できる' do
      # 質問1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス',  with: @question1.user.email
      fill_in 'パスワード', with: @question1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページに質問の題名がある。
      expect(page).to have_content(@question2.title)
      # 質問詳細ページに遷移する。
      visit question_path(@question2)
      # 質問2に「回答」ボタンがあることを確認する
      expect(page).to have_content('回答する')
      # 回答ページに遷移する
      visit new_question_answer_path(@question1)
      # フォーム情報を入力する
      fill_in '回答',  with: @answer_text
      # 送信するとAnswerモデルのカウントが１上がることの確認
      expect{
        find('input[name="commit"]').click
      }.to change { Answer.count }.by(1)
      # 詳細ページに遷移されることの確認する
      visit question_path(@question1)
      # 回答欄に回答が表示されていることを確認する
      expect(page).to have_content("#{@answer_text}")
    end
  end
   context '質問回答ができないとき' do
   it 'ログインしたユーザーは自分が投稿した質問には回答できない' do
    # 質問2を投稿したユーザーでログインする
    visit new_user_session_path
    fill_in 'メールアドレス',  with: @question2.user.email
    fill_in 'パスワード', with: @question2.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # トップページに質問の題名がある。
    expect(page).to have_content(@question2.title)
    # 質問詳細ページに遷移する。
    visit question_path(@question2)
    # 質問2に「回答」ボタンがないことの確認
    expect(page).to have_no_content('回答する')
   end
    it 'ログインしていないユーザーは回答できない' do
      # トップページにいる
      visit root_path
      # 質問１の詳細ページに遷移する
      visit question_path(@question1)
      # 質問１に「回答」ボタンがないことを確認する
      expect(page).to have_no_content('回答する')
      # 質問２の詳細ページに遷移する
      visit question_path(@question2)
      # 質問２に「回答」ボタンがないことを確認する
      expect(page).to have_no_content('回答する') 
    end
  end
end


RSpec.describe "回答編集", type: :system do
    before do
      @question1 = FactoryBot.create(:question)
      @question2 = FactoryBot.create(:question)
      @answer1 = FactoryBot.create(:answer)
      @answer2 = FactoryBot.create(:answer)
   end

   context '回答編集ができるとき' do
    it 'ログインしたユーザーは自分が回答した内容を編集することができる' do
    # 質問2を投稿したユーザーでログインする
    visit new_user_session_path
    fill_in 'メールアドレス',  with: @question2.user.email
    fill_in 'パスワード', with: @question2.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # トップページに質問の題名がある。
    expect(page).to have_content(@question1.title)
    # 質問詳細ページに遷移する。
    visit question_path(@question1)
    # 質問1に「回答」ボタンがあることを確認する
    expect(page).to have_content('回答する')
    # 回答ページに遷移する
    visit new_question_answer_path(@question1)
    # フォーム情報を入力する
    fill_in '回答',  with: @answer2.text
    # 送信するとAnswerモデルのカウントが１上がることの確認
    expect{
      find('input[name="commit"]').click
    }.to change { Answer.count }.by(1)
    # 詳細ページに遷移されることの確認する
    visit question_path(@question1)
    # 質問1の回答一覧に「編集」ボタンがあることを確認する
    expect(page).to have_content('編集')
    # 編集ページへ遷移する
    visit edit_question_answer_path(@question1, @answer2)
    # すでに投稿済みの内容がフォームに入っていることの確認
    expect(
      find('#answer_text').value
    ).to eq @answer2.text
    # 投稿内容を編集する
    fill_in '回答', with: "#{@answer2.text}+編集した回答"
     # 編集してもAnswerモデルのカウントは変わらないことを確認する
     expect{
      find('input[name="commit"]').click
    }.to change { Answer.count }.by(0)
    # 質問詳細ページに遷移する
    visit edit_question_answer_path(@question1, @answer2)
    # 質問詳細ページには先程変更した題名と質問内容が存在することを確認する。
    expect(page).to have_content("#{@answer2.text}+編集した回答")
    end
  end
   context '回答編集ができないとき' do
    it 'ログインしたユーザーは自分が投稿していない回答は編集できない' do
    # 質問1を投稿したユーザーでログインする
    visit new_user_session_path
    fill_in 'メールアドレス',  with: @answer1.user.email
    fill_in 'パスワード', with: @answer1.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # トップページに質問の題名がある。
    expect(page).to have_content(@question1.title)
    # 質問詳細ページに遷移する。
    visit question_path(@question1)
    # 質問詳細画面に「編集」ボタンな存在しない
    expect(page).to have_no_content('編集')
    end
  

  it 'ログインしていないユーザーは回答を編集できない' do
      # トップページにいる
      visit root_path
      # 質問１の詳細ページに遷移する
      visit question_path(@question1)
      # 回答欄に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集')
      # 質問２の詳細ページに遷移する
      visit question_path(@question2)
      # 回答欄に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集')
    end
  end
end


RSpec.describe "回答削除", type: :system do
  before do
      @question1 = FactoryBot.create(:question)
      @question2 = FactoryBot.create(:question)
      @answer1 = FactoryBot.create(:answer)
      @answer2 = FactoryBot.create(:answer)
   end

   context '回答削除ができるとき' do
      it 'ログインしたユーザーは自分の回答を削除することが可能である' do
      # 質問1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス',  with: (@question1 && @answer2).user.email
      fill_in 'パスワード', with: (@question1 && @answer2).user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページに質問の題名がある。
      expect(page).to have_content(@question2.title)
      # 質問詳細ページに遷移する。
      visit question_path(@question2)
      # 質問2に「回答」ボタンがあることを確認する
      expect(page).to have_content('回答する')
      # 回答ページに遷移する
      visit new_question_answer_path(@question2)
      # フォーム情報を入力する
      fill_in '回答',  with: @answer1.text
      # 送信するとAnswerモデルのカウントが１上がることの確認
      expect{
        find('input[name="commit"]').click
      }.to change { Answer.count }.by(1)
      # 詳細ページに遷移されることの確認する
      visit question_path(@question2)
      # 質問1の回答一覧に「編集」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 削除するとAnswerモデルのカウントが１下がることの確認
      expect{
        click_link '削除'
      }.to change{ Answer.count }.by(-1)
      # トップページに遷移する
      visit root_path
    end
      it 'ログインしたユーザーは自分の回答以外は削除することができない' do
        # 質問1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス',  with: (@question1 && @answer2).user.email
      fill_in 'パスワード', with: (@question1 && @answer2).user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページに質問の題名がある
      expect(page).to have_content(@question1.title)
      # 質問詳細ページに遷移する。
      visit question_path(@question1)
      # 質問1に「削除」ボタンがないことの確認
      expect(page).to have_no_content('削除')
    end
      it 'ログインしていないユーザー回答削除ができない' do
        # トップページにいる
        visit root_path
        # トップページに質問の題名がある
        expect(page).to have_content(@question1.title)
        # 質問詳細ページに遷移する。
        visit question_path(@question1)
        # 質問1に「削除」ボタンがないことの確認
        expect(page).to have_no_content('削除')
    end
  end
end


