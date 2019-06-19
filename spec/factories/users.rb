FactoryBot.define do
  factory :user do
    name "Taro Yamada"
    sequence(:email) {|idx| "taroyamada#{idx}@example.com"}
    password "taro_yamada_123456"
    
  end
end
