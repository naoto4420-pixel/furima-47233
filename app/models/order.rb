class Order < ApplicationRecord
  # アソシエーション
  belongs_to  :item
  belongs_to  :user
  has_one     :shipping_address

  # バリデーション
  ## バリデーションはorder_shippingaddress.rbに記載。
end
