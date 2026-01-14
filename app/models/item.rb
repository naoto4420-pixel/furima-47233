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
  validates :name,                        presence: true
  validates :explain,                     presence: true
  validates :price,                       presence: true
  validates :category_id,                 presence: true
  validates :condition_id,                presence: true
  validates :shipping_cost_id,            presence: true
  validates :prefecture_id,               presence: true
  validates :estimated_shipping_date_id,  presence: true

  validates :category_id,                 numericality: { other_than: 1, message: "can't be blank"}
  validates :condition_id,                numericality: { other_than: 1, message: "can't be blank"}
  validates :shipping_cost_id,            numericality: { other_than: 1, message: "can't be blank"}
  validates :prefecture_id,               numericality: { other_than: 1, message: "can't be blank"}
  validates :estimated_shipping_date_id,  numericality: { other_than: 1, message: "can't be blank"}

end
