class ShippingAddress < ApplicationRecord
  # アソシエーション
  belongs_to :order

  # バリデーション
  validates :post_code,       presence: true
  validates :prefecture_id,   presence: true
  validates :municipality,    presence: true
  validates :street_address,  presence: true
  validates :phone_number,    presence: true

end
