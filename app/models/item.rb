class Item < ApplicationRecord
  has_one :address
  has_many :images
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :delivery_day
  belongs_to :status
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
