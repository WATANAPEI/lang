FactoryBot.define do
  factory :word do
    sequence(:word) {|idx| "lya#{idx}"}
    sequence(:meaning) {|idx| "eat#{idx}"}
    association :word_lang
    association :meaning_lang

  end
end
