require 'rails_helper'

RSpec.describe 'WordsWithLanguages', type: :request do
  describe '#show' do
    before do
      @word = FactoryBot.create(:word)
    end
    it 'returns successful response' do
      get words_with_language_path(@word)
      expect(response).to have_http_status(200)
    end
    it 'returns json file with 3 data fields' do
      get words_with_language_path(@word)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json.length).to eq 3
    end
    it 'has proper payload' do
      get words_with_language_path(@word)
      json = JSON.parse(response.body, symbolize_names: true)
      loaded_data_array = json[:data]
      expect(loaded_data_array[0][:id]).to eq @word.id
      expect(loaded_data_array[0][:word]).to eq @word.word
      expect(loaded_data_array[0][:meaning]).to eq @word.meaning
      expect(loaded_data_array[0][:word_language]).to eq @word.word_lang.language_name
      expect(loaded_data_array[0][:meaning_language]).to eq @word.meaning_lang.language_name

    end
  end
end
