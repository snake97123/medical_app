require 'rails_helper'

RSpec.describe Answer, type: :model do
  before do
    @answer = FactoryBot.build(:answer)
end

describe '回答投稿' do
  context '回答投稿がうまくいくとき' do
    it 'すべての項目があれば登録できること' do
      expect(@answer).to be_valid
    end
  end
end

context '回答投稿がうまくいかないとき' do
  it '回答がからだと投稿できないこと' do
    @answer.text = nil
    @answer.valid?
    expect(@answer.errors.full_messages).to include('回答内容を入力してください')
  end
end
end
