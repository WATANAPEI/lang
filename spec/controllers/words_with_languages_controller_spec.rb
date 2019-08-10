require 'rails_helper'

RSpec.describe WordsWithLanguagesController, type: :controller do
  describe '#show' do
    context 'with proper id' do
      before do
        @word = FactoryBot.create(:word)
      end
      it 'responds successfully' do
        get :show, params: { id: @word.id }
        expect(response).to be_successful
      end
      it 'responds a 200 reponse' do
        get :show, params: { id: @word.id }
        expect(response).to have_http_status '200'
      end
    end
    context 'with invalid id' do
      it 'responds 404 response' do
        get :show, params: { id: -1 }
        expect(response).to have_http_status '404'
      end
    end
  end

end
