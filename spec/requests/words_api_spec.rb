require 'rails_helper'

RSpec.describe "WordsApi", type: :request do
  it "loads a word" do
    word = FactoryBot.create(:word)
    get words_path, params: {id: word.id}
    expect(response).to have_http_status "200"
    json = JSON.parse(response.body, symbolize_names: true)
    loaded_data_array = json[:data]
    loaded_data = loaded_data_array.first
    # the number of feilds of body
    expect(json.length).to eq 3
    # the number of loaded data 
    expect(loaded_data_array.length).to eq 1
    # check the content
    expect(loaded_data[:word]).to eq word.word
  end

  it "loads all words" do
    words = []
    5.times do
      words << FactoryBot.create(:word)
    end
    get words_path
    expect(response).to have_http_status "200"
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

  it "registers a word" do
    word = FactoryBot.build(:word)
    word_params = word.attributes.symbolize_keys.slice(:word, :meaning, :word_lang_id, :meaning_lang_id)
    expect {
      post words_path, params: {word: word_params}
    }.to change(Word, :count).by(1)
    expect(Word.last.word).to eq word_params[:word]
  end

  it "registers words" do
    word_params = []
    5.times do
      word = FactoryBot.build(:word)
      word_params << word.attributes.symbolize_keys.slice(:word,:meaning,:word_lang_id, :meaning_lang_id)
    end
    word_params.each do |word_param| 
      expect {
        post words_path, params: { word: word_param}
      }.to change(Word, :count).by(1)
      expect(response).to have_http_status "200"
    end
  end
  
  it "updates a word"

  it "deletes a word"
end
