# **freemarket_sample_73f**

メルカリのクローンアプリです。

# URL
http://18.180.168.239/

# 機能
- ユーザー新規登録、ログイン機能
- 商品出品
- 購入機能

# 開発環境
- Ruby 2.5.1
- Rails 5.2.3
- AWS EC2
- AWS S3

# 作者
・・・

# DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|mail|string|null: false|
|password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|date|null: false|
|image|string|

### Association
- has_many :cards
- has_many :products
- has_many :delivery_destination

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|image|references|null: false,foreign_key: true|
|name|string|null: false,index|
|explanation|string|null: false,index|
|category|references|null: false,foreign_key: true|
|size|string|null: false|
|brand_name|string|index|
|condition|references|null: false,foreign_key: true|
|delivery_fee|references|null: false,foreign_key: true|
|prefecture|references|null: false,foreign_key: true|
|delivery_days|references|null: false,foreign_key: true|
|price|integer|null: false|
|status|references|null: false,foreign_key: true|
|user|references|null: false,foreign_key: true|

### Association
- has_one :delivery_destination
- has_many :images
- has_many :categories1
- has_many :condition
- has_many :delivery_fee
- has_many :prefectures
- has_many :delivery_days
- has_many :status
- belongs_to :user

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|

### Association
- belongs_to :item

## categories1テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :categories2
- belongs_to :item

## categories2テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|categories1|references|null: false,foreign_key: true|

### Association
- has_many :categories3
- belongs_to :item
- belongs_to :categories1

## categories3テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|categories2|references|null: false,foreign_key: true|

### Association
- belongs_to :item
- belongs_to :categories2

## conditionテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- belongs_to :item

## delivery_feeテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- belongs_to :item

## prefecturesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- belongs_to :item
- belongs_to :delivery_destination

## delivery_daysテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- belongs_to :item

## statusテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- belongs_to :item

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|user|references|null: false,foreign_key: true|
|card|references|null: false,foreign_key: true|

### Association
- belongs_to :user

## delivery_destinationテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|postal_code|integer|null: false|
|prefecture|references|null: false,foreign_key: true|
|city|string|null: false|
|house_number|string|null: false|
|house_name|string|

### Association
- has_many :prefectures
- belongs_to :user
- belongs_to :item