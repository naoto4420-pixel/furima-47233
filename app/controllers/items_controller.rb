class ItemsController < ApplicationController
  # アクション前処理
  before_action :set_item,            only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,  only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  # アクション
  def index
    @items = Item.includes(:user).order("created_at DESC")
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

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  # プライベートメソッド
  private

  # ストロングパラメーターパラメーター設定
  def item_params
    params.require(:item).permit(:image, :name, :explain, :price, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :estimated_shipping_date_id).merge(user_id: current_user.id)
  end

  # itemデータ格納
  def set_item
    @item = Item.find(params[:id])
  end

  # 商品出品者と操作するユーザーが同じことの確認
  def ensure_correct_user
    if @item.user_id != current_user.id
      redirect_to action: :index
    end
  end

end
