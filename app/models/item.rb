class Item < ApplicationRecord
  has_one :address
  has_many :images, dependent: :destroy
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :delivery_day
  belongs_to :status
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  # お気に入り登録用
  has_many :favorites
  has_many :users, through: :favorites

  # 子モデルのバリデーションチェック
  validates_associated :images
  validates :images, presence: true

  # バリデーション
  validates :name,:explanation,:category_id,:condition_id,:delivery_fee_id,:prefecture_id,:delivery_day_id,:price, presence: true
  # ↓条件付き必須・・・カテゴリによって必須になる
  # validates :size, presence: true

  accepts_nested_attributes_for :images, allow_destroy: true
end
