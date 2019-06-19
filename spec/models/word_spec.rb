require 'rails_helper'

RSpec.describe Word, type: :model do

  before do
#   @lang_en = Language.create(
#     language_name: "English",
#   )
#   @lang_tu = Language.create(
#     language_name: "Tumbuka"
#   )
    @lang1= FactoryBot.create(:language)
    @lang2 = FactoryBot.create(:language)
  end
  it "is valid with a word, a meaning, word language and meaning language" do
    word = Word.new(
      word: "lya",
      meaning: "eat",
      word_lang_id: @lang1.id,
      meaning_lang_id: @lang2.id
    )
    expect(word).to be_valid
  end

  it "is invalid without a word" do
    word = Word.new(
      word: nil
    )
    word.valid?
    expect(word.errors[:word]).to include("can't be blank")
  end

  it "is invalid without a meaning" do
    word = Word.new(
      meaning: nil
    )
    word.valid?
    expect(word.errors[:meaning]).to include("can't be blank")

  end

  it "is invalid without a word language" do
    word = Word.new(
      word: "lya",
      meaning: "eat",
    )
    word.meaning_lang = @lang2
    expect(word).to_not be_valid
  end

  it "is invalid without a meaning language" do
    word = Word.new(
      word: "lya",
      meaning: "eat",
    )
    word.word_lang = @lang1
    expect(word).to_not be_valid
  end

  it "is unique within a word language" do
    word = Word.create(
      word: "lya",
      meaning: "eat",
      word_lang_id: @lang1.id,
      meaning_lang_id: @lang2.id
    )
    dup_word = Word.new(
      word: "lya",
      meaning: "aaa",
      word_lang_id: @lang1.id,
      meaning_lang_id: @lang2.id
    )
    expect(dup_word).to be_invalid
  end

  it "is unique within a meaning language" do
    word = Word.create(
      word: "lya",
      meaning: "eat",
      word_lang_id: @lang1.id,
      meaning_lang_id: @lang2.id
    )
    dup_word = Word.new(
      word: "aaa",
      meaning: "eat",
      word_lang_id: @lang1.id,
      meaning_lang_id: @lang2.id
    )
    expect(dup_word).to be_invalid

  end

end
