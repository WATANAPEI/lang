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
      before do
        @word = FactoryBot.build(:word)
        @word_params = @word.attributes.symbolize_keys.slice(:word, :meaning, :word_lang_id, :meaning_lang_id)
      end
      it "adds a word" do
        expect {
          post :create, params: {word: @word_params}
        }.to change(Word, :count).by(1)
      end

      it "responds a 200 status" do
        post :create, params: {word: @word_params}
        expect(response).to have_http_status "200"
      end
    end
    context "with invalid params" do
      before do
        @word = FactoryBot.build(:word)
        # slip meaning_lang_id
        @word_params = @word.attributes.symbolize_keys.slice(:word, :meaning, :word_lang_id) 
      end
      it "responds a 200 status" do
        post :create, params: {word: @word_params}
        expect(response).to have_http_status "200"
      end
      it "does not save a word" do
        post :create, params: {word: @word_params}
        expect {
          post :create, params: {word: @word_params}
        }.to change(Word, :count).by(0)
      end
    end
  end

  describe "#update" do
    before do
      @saved_word = FactoryBot.create(:word, meaning: "original_meaning")
      @word = FactoryBot.build(:word)
      @word_params = @word.attributes.symbolize_keys.slice(:word, :meaning, :word_lang_id, :meaning_lang_id)
      @word_params[:meaning] = "changed_meaning"
    end
    context "with proper params" do
      it "modifies a word" do
        patch :update, params: {id: @saved_word.id, word: @word_params }
        expect(@saved_word.reload.meaning).to eq "changed_meaning"
      end

      it "responds a 200 status" do
        patch :update, params: {id: @saved_word.id, word: @word_params }
        expect(response).to have_http_status "200"

      end
    end
    context "with invalid word id" do
      it "responds 404 error status" do
        patch :update, params: {id: -1 , word: @word_params }
        expect(response).to have_http_status "404"
      end

      it "does not update a word" do
        patch :update, params: {id: -1 , word: @word_params }
        expect(@saved_word.meaning).to eq "original_meaning"
      end
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
      it "responds a 200 status" do
        word = FactoryBot.create(:word)
        delete :destroy, params: {id: word.id}
        expect(response).to have_http_status "200"
      end
    end

    context "with invalid param" do
      before do
        @word = FactoryBot.create(:word)
      end
      it "returns a 404 status" do
        delete :destroy, params: {id: -1}
        expect(response).to have_http_status "404"
      end

      it "does not delete a word" do
        expect { 
        delete :destroy, params: {id: -1}
        }.to change(Word, :count).by(0)
      end
    end
  end
end
