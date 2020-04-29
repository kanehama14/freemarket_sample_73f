class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,               null: false, index: true
      t.string :explanation,        null: false, index: true
      t.references :category,       null: false, foreign_key: true
      t.string :size,               null: false
      t.string :brand_name,         index: true
      t.references :condition,      null: false, foreign_key: true
      t.references :delivery_fee,   null: false, foreign_key: true
      t.integer :prefecture_id,     null: false
      t.references :delivery_days,  null: false, foreign_key: true
      t.integer :price,             null: false
      t.references :status,         null: false, foreign_key: true
      t.references :user,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
