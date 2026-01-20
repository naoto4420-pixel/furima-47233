class OrdersController < ApplicationController
  # アクション前処理
  before_action :authenticate_user!, only: [:index, :create]

  # アクション
  def index
    set_item

    # 自身の出品した商品、または売却済み商品の時はルートパス遷移
    redirect_to root_path if @item.is_sold? || (@item.user_id == current_user.id)

    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_params)

    if @order_shipping_address.valid?
      pay_item
      @order_shipping_address.save
      redirect_to root_path
    else
      set_item
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  # プライベートメソッド
  private

  # ストロングパラメーターパラメーター設定(ShippingAddressモデル)
  def order_params
    params.require(:order_shipping_address).permit(:post_code, :prefecture_id, :municipality,
                                                   :street_address, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  # itemデータ格納
  def set_item
    @item = Item.find(params[:item_id])
  end

  # PAY.JP処理実行
  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(@order_shipping_address.item_id).price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
