FactoryBot.define do
  factory :word do
    word "lya"
    meaning "eat"
    association :word_lang
    association :meaning_lang
  end
end
