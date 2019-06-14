class WordsController < ApplicationController
  def index
    words = Words.order()
  end
end
