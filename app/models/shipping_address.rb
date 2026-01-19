class ShippingAddress < ApplicationRecord
  # アソシエーション
  belongs_to :order

  # バリデーション
  ## バリデーションはorder_shippingaddress.rbに記載。

end
