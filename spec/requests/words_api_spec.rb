# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'WordsApi', type: :request do
  it 'loads a word' do
    word = FactoryBot.create(:word)
    words = [word]
    get word_path(words)
    expect(response).to have_http_status '200'
    json = JSON.parse(response.body, symbolize_names: true)
    # the number of feilds of body
    expect(json.length).to eq 3
    loaded_data_array = json[:data]
    # the number of loaded data
    expect(loaded_data_array.length).to eq 1
    # expect(loaded_data).to be_truthy
    # check the content
    loaded_data_array.zip(words).each do |data, word|
      expect(data[:word]).to eq word.word
    end
  end

  it 'loads all words' do
    words = []
    5.times do
      words << FactoryBot.create(:word)
    end
    get words_path
    expect(response).to have_http_status '200'
    json = JSON.parse(response.body, symbolize_names: true)
    loaded_data_array = json[:data]
    # the number of loaded data
    expect(loaded_data_array.length).to eq 5
    # check the contents in returned array
    loaded_data_array.zip(words).each do |loaded_data, word|
      expect(loaded_data[:word]).to eq word[:word]
      expect(loaded_data[:meaning]).to eq word[:meaning]
      expect(loaded_data[:word_lang_id]).to eq word[:word_lang_id]
      expect(loaded_data[:meaning_lang_id]).to eq word[:meaning_lang_id]
    end
  end

  it 'registers a word' do
    word = FactoryBot.build(:word)
    word_params = word.attributes.symbolize_keys.slice(:word, :meaning, :word_lang_id, :meaning_lang_id)
    expect {
      post words_path, params: { word: word_params }
    }.to change(Word, :count).by(1)
    expect(Word.last.word).to eq word_params[:word]
  end

  it 'registers words' do
    # TODO: change test below to check array allowance
    word_params = []
    5.times do
      word = FactoryBot.build(:word)
      word_params << word.attributes.symbolize_keys.slice(:word, :meaning, :word_lang_id, :meaning_lang_id)
    end
    word_params.each do |word_param|
      expect {
        post words_path, params: { word: word_param }
      }.to change(Word, :count).by(1)
      expect(response).to have_http_status '200'
    end
  end

  it 'updates a word' do
    word = FactoryBot.create(:word, meaning: 'original_meaning')
    word_params = { meaning: 'changed_meaning' }
      # FactoryBot.build(:word).attributes.symbolize_keys.slice(:meaning)
    patch word_path(word), params: {word: word_params}
    expect(response).to have_http_status '200'
    expect(word.reload.meaning).to eq 'changed_meaning'
  end

  it 'deletes a word' do
    word = FactoryBot.create(:word)
    expect {
      delete word_path(word)
    }.to change(Word, :count).by(-1)
    expect(response).to have_http_status '200'
    json = JSON.parse(response.body, symbolize_names: true)
    # check the delete word id
    expect(word.id).to eq json[:data][:id]
  end

  it 'returns the number of words' do
    word_array = []
    10.times do
      word_array << FactoryBot.create(:word)
    end
    get count_words_path
    expect(response).to have_http_status '200'
    json = JSON.parse(response.body, symbolize_names: true)
    # check the number of words
    expect(json[:data]).to eq 10
  end

  it 'returns inquired words' do
    word_array = []
    10.times do
      word_array << FactoryBot.create(:word)
    end
    get search_words_path, params: {word: word_array[0].word}
    expect(response).to have_http_status '200'
    json = JSON.parse(response.body, symbolize_names: true)
    loaded_data = json[:data]
    # the number of loaded data
    expect(loaded_data).to be_truthy
    # check the content
    expect(loaded_data[0][:word]).to eq word_array[0].word
    expect(loaded_data[0][:meaning]).to eq word_array[0].meaning
    get search_words_path, params: { meaning: word_array[1].meaning}
    expect(response).to have_http_status '200'
    json = JSON.parse(response.body, symbolize_names: true)
    loaded_data = json[:data]
    # the number of loaded data
    expect(loaded_data).to be_truthy
    # check the content
    expect(loaded_data[0][:word]).to eq word_array[1].word
    expect(loaded_data[0][:meaning]).to eq word_array[1].meaning
    get search_words_path, params: {word: "lya"}
    json = JSON.parse(response.body, symbolize_names: true)
    loaded_data = json[:data]
    # the number of loaded data
    expect(loaded_data.length).to eq 10
  end
end
