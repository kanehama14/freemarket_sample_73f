require 'rails_helper'
describe Card do
  
  describe '#create' do

    it "全ての必須項目が入力されている場合は登録できる" do
      card = FactoryBot.build(:card)
      expect(card).to be_valid
    end

    it "カスタマーIDがなければ登録できない" do
      expect(FactoryBot.build(:card, customer_id: "")).to_not be_valid 
    end

    it "カードIDがなければ登録できない" do
      expect(FactoryBot.build(:card, card_id: "")).to_not be_valid 
    end

  end
end