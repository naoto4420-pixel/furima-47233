class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #バリデーション
  validates :nickname,          presence: true
  
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :family_name,       presence: true
    validates :first_name,        presence: true
  end
  
  with_options presence: true, format: { with: /\A[ァ-ヴ]+\z/ } do
    validates :family_name_kana,  presence: true
    validates :first_name_kana,   presence: true
  end
  
  validates :birthday,          presence: true
  
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英字と数字を必ず両方使い、それらのみで構成してください。' 

end
