class WordsController < ApplicationController
  def index
    words = Word.all
    render json: {status: 'SUCCESS', message: 'loaded words', data: words }
  end

  def show
    word = Word.find(params[:id])
    render json: {status: 'SUCCESS', message: 'loaded the word', data: word }
  end

  def create
    word = Word.new(word_params)
    if word.save
      render json: { status: 'SUCCESS', message: 'loaded the word', data: word }
    else
      render json: { status: 'ERROR', message: 'word not saved', data: word.errors }
    end
  end

  def destroy
    word = Word.find(params[:id])
    word.destroy
    render json: { status: 'SUCCESS', message: 'deleted the word', data: word }
  end

  def update
    word = Word.find(params[:id])
    if word.update(word_params)
      render json: { status: 'SUCCESS', message: 'updated the word', data: word }
    else
      render json: {status: 'ERROR', message: 'word not updated', data: word.errors}
    end
  end

  private
  def word_params
    params.require(:word).permit(:word, :meaning, :word_lang_id,:meaning_lang_id)
  end
end
