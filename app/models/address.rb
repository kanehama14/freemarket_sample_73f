class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :item
  validates :postal_code, :prefecture_id, :city, :house_number ,presence: true

  validates :postal_code,presence: true,
            format: { 
              with: /\A\d{7}\z/, 
              message: "ハイフンなしの英数字で入力してください"
            }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
