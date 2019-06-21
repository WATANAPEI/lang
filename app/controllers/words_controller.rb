class WordsController < ApplicationController
  def index
    words = Word.all
    render json: {status: 'SUCCESS', message: 'words are loaded', data: words }
  end

  def show
    word = Word.find(params[:id])
    render json: {status: 'SUCCESS', message: 'the word is loaded', data: word }
  end

  def create
    word = Word.new(word_params)
    if word.save
      render json: { status: 'SUCCESS', message: 'the word is saved.', data: word }
    else
      render json: { status: 'ERROR', message: 'the word is not saved', data: word.errors }
    end
  end

  def destroy
    word = Word.find(params[:id])
    word.destroy
    render json: { status: 'SUCCESS', message: 'the word is  deleted', data: word }
  end

  def update
    word = Word.find(params[:id])
    if word.update(word_params)
      render json: { status: 'SUCCESS', message: 'the word is updated', data: word }
    else
      render json: {status: 'ERROR', message: 'the word is not updated', data: word.errors}
    end
  end

  private
  #TODO: make possible to catch array of hash
  def word_params
    params.require(:word).permit(:word, :meaning, :word_lang_id,:meaning_lang_id)
#   params.require(:word).map( |u| u.permit(:word, :meaning, :word_lang_id, :meaning_lang_id) }
  end
end
