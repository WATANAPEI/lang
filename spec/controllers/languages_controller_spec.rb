require 'rails_helper'

RSpec.describe LanguagesController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end

    it "returns a 200 status" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "#show" do
    before do
      @language = FactoryBot.create(:language)
    end
    context "with proper params" do
      it "responds successfully" do
        get :show, params: {id: @language.id}
        expect(response).to be_successful
      end

      it "returns a 200 status" do
        get :show, params: {id: @language.id}
        expect(response).to have_http_status "200"
      end
    end

    context "with invalid id" do
      it "returns a 404 status" do
        get :show, params: {id: -1}
        expect(response).to have_http_status "404"
      end
    end
  end

  describe "#create" do
    context "with proper params" do
      it "add a word" do
        language_params = FactoryBot.attributes_for(:language)
        expect {
          post :create, params: {language: language_params}
        }.to change(Language, :count).by(1)
      end

      it "returns a 200 status" do
        language_params = FactoryBot.attributes_for(:language)
        post :create, params: {language: language_params}
        expect(response).to have_http_status "200"
      end
    end

    context "with invalid params" do
      before do
        @language_params = FactoryBot.attributes_for(:language, language_name: nil)
      end
      it "does not add a word" do
        expect {
          post :create, params: {language: @language_params}
        }.to change(Language, :count).by(0)
      end

      it "returns a 200 status" do
        post :create, params: {language: @language_params}
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#update" do
    before :each do
      @saved_language = FactoryBot.create(:language, language_name: "original_name")
      @language_params = FactoryBot.attributes_for(:language, language_name: "changed_name")
    end

    context "with proper params" do
      it "returns a 200 status" do
        patch :update, params: {id: @saved_language.id, language: @language_params}
        expect(response).to have_http_status "200"
      end

      it "change a language" do
        patch :update, params: {id: @saved_language.id, language: @language_params}
        expect(@saved_language.reload.language_name).to eq "changed_name" 
      end
    end

    context "with invalid id" do
      it "returns a 404 status" do
        patch :update, params: {id: -1, language: @language_params}
        expect(response).to have_http_status "404"
      end

      it "does not change a word" do
        patch :update, params: {id: -1, language: @language_params}
        expect(@saved_language.reload.language_name).to eq "original_name"
      end
    end
  end

  describe "#destory" do
    before do
      @saved_language = FactoryBot.create(:language)
    end
    context "with proper params" do
      it "returns a 200 status" do
        delete :destroy, params: {id: @saved_language.id}
        expect(response).to have_http_status "200"
      end

      it "delete a word" do
        expect {
          delete :destroy, params: {id: @saved_language.id}
        }.to change(Language, :count).by(-1)
      end
    end

    context "with invalid id" do
      it "returns 404 status" do
        delete :destroy, params: {id: -1}
        expect(response).to have_http_status "404"
      end

      it "does not delete a word" do
        expect {
          delete :destroy, params: {id: -1}
        }.to change(Language, :count).by(0)
      end
    end
  end

end
