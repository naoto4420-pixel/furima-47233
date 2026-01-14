class Item < ApplicationRecord
  # アソシエーション
  belongs_to :user

  # バリデーション
  validates :name,                        presence: true
  validates :explain,                     presence: true
  validates :price,                       presence: true
  validates :category_id,                 presence: true
  validates :condition_id,                presence: true
  validates :shipping_cost_id,            presence: true
  validates :prefecture_id,               presence: true
  validates :estimated_shipping_date_id,  presence: true

end
