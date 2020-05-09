require 'rails_helper'
describe Item do
  describe '#create' do
    it "全ての必須項目が入力されている場合出品できる" do
      item = FactoryBot.build(:item)
      expect(item).to be_valid
    end

    it "商品名がない場合は登録できないこと" do
      item = FactoryBot.build(:item, name: nil)
      item.valid?
      # expect(item.errors[:name])　＝　include("を入力してください")
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "商品説明がない場合は登録できないこと" do
      item = FactoryBot.build(:item, explanation: nil)
      item.valid?
      expect(item.errors[:explanation]).to include("を入力してください")
    end

    it "カテゴリがない場合は登録できないこと" do
      item = FactoryBot.build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end


    it "商品状態がない場合は登録できないこと" do
      item = FactoryBot.build(:item, condition_id: nil)
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    it "配送料がない場合は登録できないこと" do
      item = FactoryBot.build(:item, delivery_fee_id: nil)
      item.valid?
      expect(item.errors[:delivery_fee_id]).to include("を入力してください")
    end

    it "都道府県がない場合は登録できないこと" do
      item = FactoryBot.build(:item, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "都道府県がない場合は登録できないこと" do
      item = FactoryBot.build(:item, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "配達日がない場合は登録できないこと" do
      item = FactoryBot.build(:item, delivery_day_id: nil)
      item.valid?
      expect(item.errors[:delivery_day_id]).to include("を入力してください")
    end

    it "金額がない場合は登録できないこと" do
      item = FactoryBot.build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

  end
  describe '#update' do
    it "全ての必須項目が入力されている場合出品できる" do
      item = FactoryBot.build(:item)
      expect(item).to be_valid
    end

    it "商品名がない場合は登録できないこと" do
      item = FactoryBot.build(:item, name: nil)
      item.valid?
      # expect(item.errors[:name])　＝　include("を入力してください")
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "商品説明がない場合は登録できないこと" do
      item = FactoryBot.build(:item, explanation: nil)
      item.valid?
      expect(item.errors[:explanation]).to include("を入力してください")
    end

    it "カテゴリがない場合は登録できないこと" do
      item = FactoryBot.build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end


    it "商品状態がない場合は登録できないこと" do
      item = FactoryBot.build(:item, condition_id: nil)
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    it "配送料がない場合は登録できないこと" do
      item = FactoryBot.build(:item, delivery_fee_id: nil)
      item.valid?
      expect(item.errors[:delivery_fee_id]).to include("を入力してください")
    end

    it "都道府県がない場合は登録できないこと" do
      item = FactoryBot.build(:item, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "都道府県がない場合は登録できないこと" do
      item = FactoryBot.build(:item, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "配達日がない場合は登録できないこと" do
      item = FactoryBot.build(:item, delivery_day_id: nil)
      item.valid?
      expect(item.errors[:delivery_day_id]).to include("を入力してください")
    end

    it "金額がない場合は登録できないこと" do
      item = FactoryBot.build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

  end
end