FactoryBot.define do

  factory :user do
    name {"hoge"}
    email {"a@example.com"}
    password {"1234qwer"}
    password_confirmation {"1234qwer"}
    first_name {"山田"}
    last_name {"次郎"}
    first_name_kana {"やまだ"}
    last_name_kana {"じろう"}
    birthday {"2000-01-01"}

  end
end