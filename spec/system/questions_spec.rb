require 'rails_helper'

RSpec.describe '質問投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @question_title = Faker::Lorem.sentence
    @question_content = Faker::Lorem.sentence
  end
  context '質問投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 質問投稿ページへのリンクがあることを確認する
      expect(page).to have_content('質問する')
      # 質問投稿ページに遷移する
      visit new_question_path
      # フォーム情報を入力する
      fill_in '題名', with: @question_title
      fill_in '質問内容', with: @question_content
      # 送信するとQuestionモデルのカウントが１上がることの確認
      expect  do
        find('input[name="commit"]').click
      end.to change { Question.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページに先程投稿した質問の題名があることの確認
      expect(page).to have_content(@question_title)
    end
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

RSpec.describe '質問詳細', type: :system do
  before do
    @question = FactoryBot.create(:question)
  end
  context '質問詳細が表示される' do
    it 'ログインしたユーザーは質問詳細ページに遷移して質問詳細が表示される' do
      #  ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @question.user.email
      fill_in 'パスワード', with: @question.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 詳細ページに遷移する
      visit question_path(@question)
      # 詳細ページに質問の題名と内容が存在する
      expect(page).to have_content(@question.title.to_s)
      expect(page).to have_content(@question.content.to_s)
    end

    it 'ログインしていないユーザーは質問詳細ページに遷移して質問の詳細が表示される' do
      # トップページに移動する
      visit root_path
      # 詳細ページに遷移する
      visit question_path(@question)
      # 詳細ページに質問の題名と内容が存在する
      expect(page).to have_content(@question.title.to_s)
      expect(page).to have_content(@question.content.to_s)
    end
  end
end
RSpec.describe '質問編集', type: :system do
  before do
    @question1 = FactoryBot.create(:question)
    @question2 = FactoryBot.create(:question)
  end
  context '質問編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した質問の編集ができる' do
      # 質問1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @question1.user.email
      fill_in 'パスワード', with: @question1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページに質問の題名がある。
      expect(page).to have_content(@question1.title)
      # 質問詳細ページに遷移する。
      visit question_path(@question1)
      # 質問１に「編集」ボタンがあることを確認する
      expect(page).to have_content('編集する')
      # 編集ページへ遷移する
      visit edit_question_path(@question1)
      # すでに投稿済みの内容がフォームに入っていることの確認
      expect(
        find('#question_title').value
      ).to eq @question1.title
      expect(
        find('#question_content').value
      ).to eq @question1.content
      # 投稿内容を編集する
      fill_in '題名', with: "#{@question1.title}+編集した題名"
      fill_in '質問内容', with: "#{@question1.content}+編集した質問内容"
      # 編集してもQuestionモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Question.count }.by(0)
      # 質問詳細ページに遷移する
      visit question_path(@question1)
      # 質問詳細ページには先程変更した題名と質問内容が存在することを確認する。
      expect(page).to have_content("#{@question1.title}+編集した題名")
      expect(page).to have_content("#{@question1.content}+編集した質問内容")
      # トップページに先程変更した題名が存在することの確認
      visit root_path
      expect(page).to have_content("#{@question1.title}+編集した題名")
    end
  end

  context '質問編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した質問の編集画面には遷移できない' do
      # 質問１を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @question1.user.email
      fill_in 'パスワード', with: @question1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 質問２の詳細ページに遷移する
      visit question_path(@question2)
      # 質問２に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集する')
    end
    it 'ログインしていないと質問の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 質問１の詳細ページに遷移する
      visit question_path(@question1)
      # 質問１に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集する')
      # 質問２の詳細ページに遷移する
      visit question_path(@question2)
      # 質問２に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集する')
    end
  end
end

RSpec.describe '質問削除', type: :system do
  before do
    @question1 = FactoryBot.create(:question)
    @question2 = FactoryBot.create(:question)
  end
  context '質問削除ができるとき' do
    it 'ログインしたユーザーは自ら投稿した質問の削除ができる' do
      # 質問1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @question1.user.email
      fill_in 'パスワード', with: @question1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページに質問の題名がある。
      expect(page).to have_content(@question1.title)
      # 質問詳細ページに遷移する。
      visit question_path(@question1)
      # 質問１に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除する')
      # 投稿を削除するとレコードが１減ることを確認する
      expect do
        find_link('削除する', href: question_path(@question1)).click
      end.to change { Question.count }.by(-1)
      # トップページに遷移する
      visit root_path
      # トップページには質問１の題名が存在しないことを確認する。
      expect(page).to have_no_content(@question1.title.to_s)
    end
  end
  context '質問削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # 質問１を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @question1.user.email
      fill_in 'パスワード', with: @question1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 質問２の詳細ページに遷移する
      visit question_path(@question2)
      # 質問２に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除する')
    end
    it 'ログインしていないと質問の削除ボタンがない' do
      # トップページにいる
      visit root_path
      # 質問１の詳細ページに遷移する
      visit question_path(@question1)
      # 質問１に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除する')
      # 質問２の詳細ページに遷移する
      visit question_path(@question2)
      # 質問２に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除する')
    end
  end
end
