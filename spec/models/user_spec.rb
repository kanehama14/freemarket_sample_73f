require 'rails_helper'
describe User do
  describe '#create' do
    it "nameがない場合は登録できないこと" do
      user = FactoryBot.build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
    
    #it "全ての必須項目が入力されている場合出品できる" do
    #  item = FactoryBot.build(:item)
    #  expect(item).to be_valid
    #end

  end
end