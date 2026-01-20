class Item < ApplicationRecord
  # アソシエーション
  belongs_to  :user
  has_one     :order
  ## リスト用ActiveHashのモデル
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :estimated_shipping_date
  ## 画像管理用モデル
  has_one_attached :image

  # バリデーション
  validates :image,                       presence: true
  validates :name,                        presence: true
  validates :explain,                     presence: true
  validates :price, presence: { message: "can't be blank" }
  validates :price, numericality: { only_integer: true, message: 'using half-width digits only' }, allow_blank: true
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'value out of range' }, allow_blank: true, if: -> { errors[:price].blank? }
  validates :category_id,                 presence: true,
                                          numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id,                presence: true,
                                          numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_cost_id,            presence: true,
                                          numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,               presence: true,
                                          numericality: { other_than: 1, message: "can't be blank" }
  validates :estimated_shipping_date_id,  presence: true,
                                          numericality: { other_than: 1, message: "can't be blank" }

  # メソッド
  ## 売却済み判定
  ## 購入記録テーブルにあるかチェック
  ## 戻り値：true…データあり、false…データなし
  def is_sold?
    order.present?
  end
end
