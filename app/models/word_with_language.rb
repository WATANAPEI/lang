class WordWithLanguage
  include ActiveModel::Model

  attr_accessor :id, :word, :meaning, :word_language, :meaning_language

  def initialize(aWord)
    @id = aWord.id
    @word = aWord.word
    @meaning = aWord.meaning
    @word_language = aWord.word_lang.language_name
    @meaning_language = aWord.meaning_lang.language_name
  end
end
