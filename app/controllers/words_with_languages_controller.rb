class WordsWithLanguagesController < ApplicationController
  include JsonFormat

  def show
    word = Word.find(params[:id])
    word_with_language = WordWithLanguage.new(word)
    word_with_languages = [word_with_language]
#   word_language = word.word_lang.language_name
#   meaning_language = word.meaning_lang.language_name
#   payload = [{
#     id: word.id,
#     word: word.word,
#     meaning: word.meaning,
#     word_lang: word_language,
#     meaning_lang: meaning_language
#   }]
    json_format('SUCCESS', 'the word is loaded with language', word_with_languages)
  end
end
