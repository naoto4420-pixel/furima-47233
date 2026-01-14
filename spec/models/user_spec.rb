require 'rails_helper'

RSpec.describe User, type: :model do

  #ユーザーデータの事前生成
  ##生成データの詳細はspec\factories\users.rbファイルを参照。
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    
    context '新規登録できるとき' do
      it '入力内容が正しければ新規登録できる' do
        expect(@user).to be_valid
      end

      #氏名に漢字が使えることはFactoryBotのテストデータで設定しているので省略

      it '名字にひらがなが使える' do
        @user.family_name = "さとう"
        expect(@user).to be_valid
      end

      it '名前にひらがなが使える' do
        @user.first_name = "たろう"
        expect(@user).to be_valid
      end

      it '名字にカタカナが使える' do
        @user.family_name = "サトウ"
        expect(@user).to be_valid
      end

      it '名前にカタカナが使える' do
        @user.first_name = "タロウ"
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '同じメールアドレスは登録できない' do
        user = FactoryBot.build(:user)
        user.save
        @user.email = user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it 'メールアドレスには＠を含める必要がある' do
        @user.email = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'パスワードが空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが6文字未満ときは登録できない' do
        @user.password = "123ab"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'パスワードは半角英字のみだと登録できない' do
        @user.password = "password"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英字と数字を必ず両方使い、それらのみで構成してください。")
      end

      it 'パスワードは半角数字のみだと登録できない' do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英字と数字を必ず両方使い、それらのみで構成してください。")
      end

      it 'パスワードは半角英数字以外が含まれると登録できない' do
        @user.password = "ab[]12"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英字と数字を必ず両方使い、それらのみで構成してください。")
      end  
        
      it 'パスワードとパスワード確認が異なる場合は登録できない' do
        @user.password = "password1"
        @user.password_confirmation = "password2"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)の名字が空では登録できない' do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it 'お名前(全角)の名前が空では登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '名字は全角以外では登録できない' do
        @user.family_name = "family"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end

      it '名前は全角以外では登録できない' do
        @user.first_name = "first"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it '名字(全角カナ)が空では登録できない' do
        @user.family_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it '名前(全角カナ)が空では登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '名字(全角カナ)は全角以外では登録できない' do
        @user.family_name_kana = "family"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid")
      end

      it '名前(全角カナ)は全角以外では登録できない' do
        @user.first_name_kana = "first"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

      it '生年月日が空では登録できない' do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end

  end

end
