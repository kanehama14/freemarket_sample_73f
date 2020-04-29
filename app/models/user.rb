class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday ,presence: true
  validates :first_name,:last_name,
            format: {
              with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,
              message: "全角で入力して下さい"
            }
  validates :first_name_kana,:last_name_kana,
            format: {
              with: /\A[ぁ-んー－]+\z/,
              message: "全角ひらがなのみで入力して下さい"
            }

  has_many :cards
  has_many :items
  has_many :delivery_destinations
  
end
