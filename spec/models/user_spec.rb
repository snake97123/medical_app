require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '必要事項があれば登録できる' do
        expect(@user).to be_valid
      end
    end
  end

  context '新規登録がうまくいかないとき' do
    it 'ニックネームが空では登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('ニックネームを入力してください')
    end
    it 'Eメールが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールを入力してください')
    end
    it 'Eメール@を含まないと登録できないこと' do
      @user.email = '12yahoo.co.jp'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end
    it '重複したEメールが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it 'パスワードが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください')
    end
    it 'パスワードが英数混合だが、字数が5文字以下であれば登録できないこと' do
      @user.password = '2oo34'
      @user.password_confirmation = '2oo34'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'パスワードが半角英語のみだと登録できないこと' do
      @user.password = 'aaaaaaaa'
      @user.password_confirmation = 'aaaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end
    it 'パスワードが数字のみだと登録できないこと' do
      @user.password = '12334456'
      @user.password_confirmation = '12334456'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end
    it 'パスワードが全角では登録できないこと' do
      @user.password = '１２３４AA８'
      @user.password_confirmation = '１２３４AA８'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end
    it '電話番号が空では登録できないこと' do
      @user.phone_number = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('電話番号を入力してください')
    end
    it '電話番号が0から始まらない場合は登録できない' do
      @user.phone_number = '48993898888'
      @user.valid?
      expect(@user.errors.full_messages).to include('電話番号は不正な値です')
    end
    it '電話番号が11桁でなかったら登録できない' do
      @user.phone_number = '99944033'
      @user.valid?
      expect(@user.errors.full_messages).to include('電話番号は不正な値です')
    end
  end
end
