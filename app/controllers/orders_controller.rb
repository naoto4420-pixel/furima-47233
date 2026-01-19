class OrdersController < ApplicationController
  # アクション前処理
  before_action :authenticate_user!,  only: [:index, :create]

  # アクション
  def index
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_params)
    
    if @order_shipping_address.valid?
      @order_shipping_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end


  # プライベートメソッド
  private

  # ストロングパラメーターパラメーター設定(ShippingAddressモデル)
  def order_params
    params.require(:order_shipping_address).permit(:post_code, :prefecture_id, :municipality, 
                                                   :street_address, :building_name, :phone_number).merge(item_id: :item_id, user_id: current_user.id)
  end

end
