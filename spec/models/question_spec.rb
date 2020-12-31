require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
    @question = FactoryBot.build(:question)
end


describe '質問投稿' do
  context '質問投稿がうまくいくとき' do
    it  'すべての項目があれば登録できること' do
      expect(@question).to be_valid
    end
  end
end

context '質問投稿がうまくいかないとき' do
  it 'タイトルが空だと登録できない' do
    @question.title = nil
    @question.valid?
    expect(@question.errors.full_messages).to include('題名を入力してください')
  end
  it '内容が空だと入力できない' do
    @question.content = nil
    @question.valid?
    expect(@question.errors.full_messages).to include('質問内容を入力してください')
  end
end
end
