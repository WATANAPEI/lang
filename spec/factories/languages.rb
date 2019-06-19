FactoryBot.define do
  factory :language, aliases: [:word_lang, :meaning_lang] do
    sequence(:language_name){|idx| "lang#{idx}"}
  end
end
