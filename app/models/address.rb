class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :item
  validates :zipcode, :address ,presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
