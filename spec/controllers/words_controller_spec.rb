require 'rails_helper'

RSpec.describe WordsController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end
  describe "#show" do
    before do
      @word = FactoryBot.create(:word)
    end

    it "responds successfully" do
      get :show, params: {id: @word.id}
      expect(response).to be_successful
    end

    it "responds a 200 reponse" do
      get :show, params: {id: @word.id}
      expect(response).to have_http_status "200"
    end
  end

  describe "#create" do
    it "adds a word" do
      word = FactoryBot.build(:word)
      word_params = word.attributes.symbolize_keys.slice(:word, :meaning, :word_lang_id, :meaning_lang_id)
      expect {
        post :create, params: {word: word_params}
      }.to change(Word, :count).by(1)
    end
  end

end
