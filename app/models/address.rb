class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :item
  validates :postal_code, :prefecture_id, :city, :house_number, :house_name ,presence: true

  validates :postal_code,presence: true,
            format: { with: /\A\d{3}-\d{4}\z/, message: "is must NOT contain any other characters than alphanumerics." }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
