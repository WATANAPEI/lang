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

    context "with proper params" do
      it "responds successfully" do
        get :show, params: {id: @word.id}
        expect(response).to be_successful
      end

      it "responds a 200 reponse" do
        get :show, params: {id: @word.id}
        expect(response).to have_http_status "200"
      end
    end

    context "with invalid id" do
      it "responds 404 response" do
        get :show, params: {id: -1}
        expect(response).to have_http_status "404"
      end
    end
  end

  describe "#create" do
    context "with proper params" do
      it "adds a word" do
        word = FactoryBot.build(:word)
        word_params = word.attributes.symbolize_keys.slice(:word, :meaning, :word_lang_id, :meaning_lang_id)
        expect {
          post :create, params: {word: word_params}
        }.to change(Word, :count).by(1)
      end
    end
    context "with invalid params" do
      it "responds error message"
    end
  end

  describe "#update" do
    before do
      @word = FactoryBot.create(:word)
    end
    context "with proper params" do
      it "modifies a word" do
        word = FactoryBot.build(:word)
        word_params = word.attributes.symbolize_keys.slice(:word, :meaning, :word_lang_id, :meaning_lang_id)
        word_params[:meaning] = "changed_for_test"
        patch :update, params: {id: @word.id, word: word_params }
        expect(@word.reload.meaning).to eq "changed_for_test"
      end
    end
    context "with invalid params" do
      it "responds error message"
    end
  end

  describe "#destroy" do
    context "with proper param" do
      it "deletes a word" do
        word = FactoryBot.create(:word)
        expect {
          delete :destroy, params: {id: word.id}
        }.to change(Word, :count).by(-1)
      end
    end

    context "with invalid param" do
      it "returns error"
    end
  end
end
