require 'rails_helper'
describe User do
  
  describe '#create' do

    it "全ての必須項目が入力されている場合は登録できる" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "ニックネームがなければ登録できない" do
      user = FactoryBot.build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "メールアドレスがなければ登録できない" do 
      expect(FactoryBot.build(:user, email: "")).to_not be_valid 
    end

    it "メールアドレスは一意でなければ登録できない" do
      another_user = FactoryBot.create(:user, email: "taro@example.com")
      expect(FactoryBot.build(:user, email: another_user.email)).to_not be_valid
    end

    # devise.rbに記述
    it "メールアドレスは@を含んでいないと登録できない" do
      expect(FactoryBot.build(:user, email: "aaaaaaaaaaaaaa")).to_not be_valid
    end

    # devise.rbに記述
    it "メールアドレスはドメインを含んでいないと登録できない" do
      expect(FactoryBot.build(:user, email: "aaaaaaaaaaaaaa@")).to_not be_valid
    end
  
    it "パスワードがなければ登録できない" do 
      expect(FactoryBot.build(:user, password: "")).to_not be_valid 
    end

    # devise.rbに記述
    it "パスワードは7文字以上であれば登録できる" do 
      expect(FactoryBot.build(:user, password: "1234qwer", password_confirmation: "1234qwer")).to be_valid 
    end

    # devise.rbに記述
    it "パスワードは6文字以下であれば登録できない" do 
      expect(FactoryBot.build(:user, password: "123qwe", password_confirmation: "123qwe")).to_not be_valid
    end

    it "パスワードは英数字を含まなければ登録できない" do 
      expect(FactoryBot.build(:user, password: "00000000", password_confirmation: "00000000")).to_not be_valid
    end

    it "password_confirmationとpasswordが異なる場合保存できない" do 
      expect(FactoryBot.build(:user,password:"password",password_confirmation: "passward")).to_not be_valid 
    end

    it "名字がなければ登録できない" do 
      expect(FactoryBot.build(:user, first_name: "")).to_not be_valid 
    end

    it "名前がなければ登録できない" do 
      expect(FactoryBot.build(:user, last_name: "")).to_not be_valid 
    end

    it "名字（かな）がなければ登録できない" do 
      expect(FactoryBot.build(:user, first_name_kana: "")).to_not be_valid 
    end

    it "名前（かな）がなければ登録できない" do 
      expect(FactoryBot.build(:user, last_name_kana: "")).to_not be_valid 
    end

    it "生年月日がなければ登録できない" do 
      expect(FactoryBot.build(:user, birthday: "")).to_not be_valid 
    end

  end
end