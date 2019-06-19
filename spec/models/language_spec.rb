require 'rails_helper'

RSpec.describe Language, type: :model do

  it "has a valid factory method" do
    expect(FactoryBot.build(:language)).to be_valid

  end
  it "is valid with a language name" do
    lang = Language.new(language_name: "English")
    expect(lang).to be_valid
  end

  it "does not have a name except for string" do
    word_exp = /[a-zA-Z]+/
    lang = Language.new(language_name: 100)
    expect(word_exp === lang.language_name).to_not be true
  end

  it "can have many words" do
    lang = FactoryBot.create(:language, :with_words)
    expect(lang.words.length).to eq 5
  end

end
