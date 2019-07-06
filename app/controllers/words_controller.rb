# frozen_string_literal: true

class WordsController < ApplicationController
  include JsonFormat

  def index
    words = Word.all
    json_format('SUCCES', 'words are loaded', words)
  end

  def show
    word = Word.find(params[:id])
    json_format('SUCCESS', 'the word is loaded', word)
  end

  def create
    word = Word.new(word_params)
    if word.save
      json_format('SUCCESS', 'the word is saved', word)
    else
      json_format('ERROR', 'the word is not saved', word.errors)
    end
  end

  def destroy
    word = Word.find(params[:id])
    word.destroy
    json_format('SUCCESS', 'the word is deleted', word)
  end

  def update
    word = Word.find(params[:id])
    if word.update(word_params)
      json_format('SUCCESS', 'the word is updated', word)
    else
      json_format('ERROR', 'the word is not updated', word.errors)
    end
  end

  def count
    num_words = Word.count
    json_format('SUCCESS', 'the number of word is loaded', num_words)
  end

  private
  # TODO: make possible to catch array of hash
  def word_params
    params.require(:word).permit(:word, :meaning, :word_lang_id,:meaning_lang_id)
    # params.require(:word).map( |u| u.permit(:word, :meaning, :word_lang_id, :meaning_lang_id) }
  end

end
