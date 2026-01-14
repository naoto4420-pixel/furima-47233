class Item < ApplicationRecord
  # アソシエーション
  belongs_to :user
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
  validates :price,                       presence: { message: "can't be blank"}
  validates :price,                       numericality: { only_integer: true, message: "using half-width digits only" }, allow_blank: true
  with_options if: -> { errors[:price].blank? } do |v|
    v.validates :price,                       numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "value out of range" }
  end
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

end
