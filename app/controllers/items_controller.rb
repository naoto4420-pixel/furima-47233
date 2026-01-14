class ItemsController < ApplicationController
  
  # アクション
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # プライベートメソッド
  private

  # ストロングパラメーターパラメーター設定
  def item_params
    params.require(:item).permit(:image, :name, :explain, :price, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :estimated_shipping_date_id).merge(user_id: current_user.id)
  end

end
