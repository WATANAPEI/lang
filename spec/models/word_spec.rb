require 'rails_helper'

RSpec.describe Word, type: :model do

# before do
#   @lang1= FactoryBot.create(:language)
#   @lang2 = FactoryBot.create(:language)
# end
  it "is valid with a word, a meaning, word language and meaning language" do
#   word = Word.new(
#     word: "lya",
#     meaning: "eat",
#     word_lang_id: @lang1.id,
#     meaning_lang_id: @lang2.id
#   )
    word = FactoryBot.build(:word)
    puts "word inspection: #{word.inspect}"
    puts "word_lang inspection: #{word.word_lang.inspect}"
    puts "meaning_lang inspection: #{word.meaning_lang.inspect}"
    expect(word).to be_valid
  end

  it "is invalid without a word" do
#   word = Word.new(
#     word: nil
#   )
    word = FactoryBot.build(:word, word: nil)
    word.valid?
    expect(word.errors[:word]).to include("can't be blank")
  end

  it "is invalid without a meaning" do
#   word = Word.new(
#     meaning: nil
#   )
    word = FactoryBot.build(:word, meaning: nil)
    word.valid?
    expect(word.errors[:meaning]).to include("can't be blank")

  end

  it "is invalid without a word language" do
#   word = Word.new(
#     word: "lya",
#     meaning: "eat",
#   )
    word = FactoryBot.build(:word, word_lang: nil)
#   puts "word inspection: #{word.inspect}"
#   word.meaning_lang = @lang2
#   expect(word).to_not be_valid
    word.valid?
    expect(word.errors[:word_lang]).to include("must exist")
  end

  it "is invalid without a meaning language" do
#   word = Word.new(
#     word: "lya",
#     meaning: "eat",
#   )
#   word.word_lang = @lang1
    word = FactoryBot.build(:word, meaning_lang: nil)
    word.valid?
#   expect(word).to_not be_valid
    expect(word.errors[:meaning_lang]).to include("must exist")
  end

  it "is unique within a word language" do
#   word = Word.create(
#     word: "lya",
#     meaning: "eat",
#     word_lang_id: @lang1.id,
#     meaning_lang_id: @lang2.id
#   )
#   dup_word = Word.new(
#     word: "lya",
#     meaning: "aaa",
#     word_lang_id: @lang1.id,
#     meaning_lang_id: @lang2.id
#   )
    word = FactoryBot.create(:word)
    dup_word = FactoryBot.build(:word, meaning: "aaa", word_lang_id: word.word_lang_id, meaning_lang_id: word.meaning_lang_id)
#   puts "word inspect: #{word.inspect}"
#   puts "dup_word inspect: #{dup_word.inspect}"
    dup_word.valid?
#   puts "dup_word error inspect: #{dup_word.errors.inspect}"
#    expect(dup_word).to be_invalid
    expect(dup_word.errors[:word]).to include("has already been taken")
  end

  it "is unique within a meaning language" do
#   word = Word.create(
#     word: "lya",
#     meaning: "eat",
#     word_lang_id: @lang1.id,
#     meaning_lang_id: @lang2.id
#   )
#   dup_word = Word.new(
#     word: "aaa",
#     meaning: "eat",
#     word_lang_id: @lang1.id,
#     meaning_lang_id: @lang2.id
#   )
#   expect(dup_word).to be_invalid
    word = FactoryBot.create(:word)
    dup_word = FactoryBot.build(:word, word: "aaa", word_lang_id: word.word_lang_id, meaning_lang_id: word.meaning_lang_id)
    dup_word.valid?
    expect(dup_word.errors[:meaning]).to include("has already been taken")

  end

end
