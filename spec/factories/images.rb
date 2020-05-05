FactoryBot.define do

  factory :image do
    image   {File.open("#{Rails.root}/app/assets/images/pict-reason-01.jpg")}
    item
  end

end