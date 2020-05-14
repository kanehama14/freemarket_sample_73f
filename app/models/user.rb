class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday ,presence: true
  validates :first_name,:last_name,
            format: {
              with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,
              message: "は全角で入力して下さい"
            }
  validates :first_name_kana,:last_name_kana,
            format: {
              with: /\A[ぁ-んー－]+\z/,
              message: "は全角ひらがなのみで入力して下さい"
            }

  validates :password,
            format: {
              with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
              message: "は英数字を1文字以上含む必要があります"
            }

  has_many :cards
  has_many :items
  has_one :address

  # お気に入り登録用
  has_many :favorites
  has_many :fav_items, through: :favorites, source: :item
  
end
