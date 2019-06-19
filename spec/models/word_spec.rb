require 'rails_helper'

RSpec.describe Word, type: :model do

  it "is valid with a word, a meaning, word language and meaning language" do
    word = FactoryBot.build(:word)
    expect(word).to be_valid
  end

  it "is invalid without a word" do
    word = FactoryBot.build(:word, word: nil)
    word.valid?
    expect(word.errors[:word]).to include("can't be blank")
  end

  it "is invalid without a meaning" do
    word = FactoryBot.build(:word, meaning: nil)
    word.valid?
    expect(word.errors[:meaning]).to include("can't be blank")
  end

  it "is invalid without a word language" do
    word = FactoryBot.build(:word, word_lang: nil)
    word.valid?
    expect(word.errors[:word_lang]).to include("must exist")
  end

  it "is invalid without a meaning language" do
    word = FactoryBot.build(:word, meaning_lang: nil)
    word.valid?
    expect(word.errors[:meaning_lang]).to include("must exist")
  end

  it "is unique within a word language" do
    word = FactoryBot.create(:word)
    dup_word = FactoryBot.build(:word, meaning: "aaa", word_lang_id: word.word_lang_id, meaning_lang_id: word.meaning_lang_id)
    dup_word.valid?
    expect(dup_word.errors[:word]).to include("has already been taken")
  end

  it "is unique within a meaning language" do
    word = FactoryBot.create(:word)
    dup_word = FactoryBot.build(:word, word: "aaa", word_lang_id: word.word_lang_id, meaning_lang_id: word.meaning_lang_id)
    dup_word.valid?
    expect(dup_word.errors[:meaning]).to include("has already been taken")
  end
end
