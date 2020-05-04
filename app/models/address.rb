class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :item
  validates :postal_code, :prefecture_id, :city, :house_number, :house_name ,presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
