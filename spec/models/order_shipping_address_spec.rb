require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  # 購入データの事前生成
  ## 生成データの詳細は以下を参照。
  ## OrderShippingAddress: spec\factories\order_shipping_address.rb
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id, item_id: item.id)
    @order_shipping_address.token = 'tok_abcdefghijk00000000000000000'
    sleep 0.1
  end

  describe '商品購入' do
    context '商品購入できるとき' do
      it '入力内容が正しければ購入できる' do
        expect(@order_shipping_address).to be_valid
      end

      it '建物名が空でも購入できる' do
        @order_shipping_address.building_name = ''
        expect(@order_shipping_address).to be_valid
      end

      it '電話番号が10文字でも購入できる' do
        @order_shipping_address.phone_number = '1234567890'
        expect(@order_shipping_address).to be_valid
      end

      it '電話番号が11文字でも購入できる' do
        @order_shipping_address.phone_number = '12345678901'
        expect(@order_shipping_address).to be_valid
      end
    end

    context '商品購入できないとき' do
      it '郵便番号が空だと購入できない' do
        @order_shipping_address.post_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号が不正だと購入できない' do
        @order_shipping_address.post_code = '12345'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Post code is invalid")
      end

      it '都道府県が空だと購入できない' do
        @order_shipping_address.prefecture_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '都道府県が初期値では登録できない' do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空だと購入できない' do
        @order_shipping_address.municipality = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it '番地が空だと購入できない' do
        @order_shipping_address.street_address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Street address can't be blank")
      end

      it '電話番号が空だと購入できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が半角数字以外だと購入できない' do
        @order_shipping_address.phone_number = '12345あいうえお'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が10文字未満だと購入できない' do
        @order_shipping_address.phone_number = '123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が11文字を超えるだと購入できない' do
        @order_shipping_address.phone_number = '123456789012'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'ユーザーが紐づいていないと購入できない' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end

      it '商品が紐づいていないと購入できない' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'トークンが空だと購入できない' do
        @order_shipping_address.token = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end
