require 'rails_helper'
describe Address do
  
  describe '#create' do

    it "全ての必須項目が入力されている場合は登録できる" do
      address = FactoryBot.build(:address)
      expect(address).to be_valid
    end

    it "郵便番号がなければ登録できない" do
      expect(FactoryBot.build(:address, postal_code: "")).to_not be_valid 
    end

    it "郵便番号はハイフンなしの英数字7文字で入力" do
      expect(FactoryBot.build(:address, postal_code: "123-4567")).to_not be_valid 
    end

    it "都道府県コードがなければ登録できない" do 
      expect(FactoryBot.build(:address, prefecture_id: "")).to_not be_valid 
    end

    it "市区町村がなければ登録できない" do 
      expect(FactoryBot.build(:address, city: "")).to_not be_valid 
    end

    it "番地がなければ登録できない" do 
      expect(FactoryBot.build(:address, house_number: "")).to_not be_valid 
    end
    
  end
end