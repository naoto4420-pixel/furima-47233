class OrdersController < ApplicationController

  # アクション
  def index
    @order = current_user.orders.build(item_id: params[:item_id])
    @shipping_address = ShippingAddress.new
  end


end
