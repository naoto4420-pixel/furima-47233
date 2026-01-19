class OrderShippingAddress

  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipality, 
                :street_address, :building_name, :phone_number,
                :item_id, :user_id

  # バリデーション
  with_options presence: true do
    validates :post_code
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid" }, allow_blank: true, if: -> { errors[:post_code].blank? }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipality
    validates :street_address
    validates :phone_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }, allow_blank: true, if: -> { errors[:phone_number].blank? }
    validates :item_id
    validates :user_id
  end
    
  # メソッド
  def save
    # 購入記録を保存する
    order = Order.create(item_id: item_id, user_id: user_id)

    #配送先情報を保存する
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, 
                           street_address: street_address, building_name: building_name, phone_number: phone_number, 
                           order_id: order.id)
  end

end