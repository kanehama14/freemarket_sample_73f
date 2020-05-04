FactoryBot.define do
  factory :item do  #画像なしバージョン
    id                {"1"}
    name              {"商品名"}
    explanation       {"詳細"}
    category_id       {"1"}
    size              {"300"}
    brand_name        {"ブランド"}
    condition_id      {"1"}
    delivery_fee_id   {"1"}
    prefecture_id     {"1"}
    delivery_day_id   {"1"}
    price             {"1"}
    status_id         {"1"}
    user_id           {"1"}
    after(:build) do |item|                     #追記
      item.images << build(:image, item: item)  #追記
    end   
  end
end