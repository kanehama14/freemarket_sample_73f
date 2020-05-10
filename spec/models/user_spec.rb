require 'rails_helper'
describe User do
  
  describe '#create' do

    #it "全ての必須項目が入力されている場合は登録できる" do
    #  user = FactoryBot.build(:user)
    #  expect(user).to be_valid
    #end
#
    #it "nameがない場合は登録できないこと" do
    #  user = FactoryBot.build(:user, name: "")
    #  user.valid?
    #  expect(user.errors[:name]).to include("が入力されていません。")
    #end
#
    #it "emailは一意でない場合登録できないこと" do
    #  user = FactoryBot.create(:user)
    #      another_user = build(:user, email: user.email)
    #      another_user.valid?
    #      expect(another_user.errors[:email]).to include("は既に使用されています")
    #end
    
    #it "全ての必須項目が入力されている場合出品できる" do
    #  item = FactoryBot.build(:item)
    #  expect(item).to be_valid
    #end

  end
end