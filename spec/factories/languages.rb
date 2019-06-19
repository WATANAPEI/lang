FactoryBot.define do
  factory :language do
    sequence(:language_name){|idx| "lang#{idx}"}
  end
end
