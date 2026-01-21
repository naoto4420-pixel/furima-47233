class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :items
  has_many :orders

  # バリデーション
  with_options presence: true do
    validates :nickname
    validates :family_name
    validates :family_name,       format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }, allow_blank: true
    validates :first_name
    validates :first_name,        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }, allow_blank: true
    validates :family_name_kana
    validates :family_name_kana,  format: { with: /\A[ァ-ヶー]+\z/ }, allow_blank: true
    validates :first_name_kana
    validates :first_name_kana,   format: { with: /\A[ァ-ヶー]+\z/ }, allow_blank: true
    validates :birthday
  end
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英字と数字を必ず両方使い、それらのみで構成してください。'
end
