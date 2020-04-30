class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :item
  belongs_to_active_hash :prefecture
  validates :zipcode, :address ,presence: true
end
