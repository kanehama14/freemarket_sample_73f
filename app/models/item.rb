class Item < ApplicationRecord
  has_one :address
  has_many :images
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to :delivery_days
  belongs_to :status
  belongs_to :user
end
