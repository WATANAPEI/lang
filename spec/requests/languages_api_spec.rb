require 'rails_helper'

RSpec.describe 'LanguagesApi', type: :request do
  it 'registers a new language' do
    language_params = FactoryBot.attributes_for(:language)
    expect {
    post languages_path, params: {language: language_params}
    }.to change(Language, :count).by(1)
    expect(response).to have_http_status '200'
    expect(Language.last.language_name).to eq language_params[:language_name]
  end

  it 'edits a language' do
    saved_language = FactoryBot.create(:language, language_name: 'saved_name')
    language_params = FactoryBot.attributes_for(:language, language_name: 'changed_name')
    patch language_path(saved_language), params: {language: language_params}
    # check the response http status
    expect(response).to have_http_status '200'
    # check the changed data
    expect(saved_language.reload.language_name).to eq 'changed_name'
    # check the content involved in response data
    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
    expect(data[:language_name]).to eq 'changed_name'
  end

  it 'deletes a language' do
    saved_language = FactoryBot.create(:language)
    saved_language_id = saved_language.id
    expect{
      delete language_path(saved_language)
    }.to change(Language, :count).by(-1)
    # check the response http status
    expect(response).to have_http_status '200'
    # check the deleted data id
    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
    expect(data[:id]).to eq saved_language_id
  end

  it 'shows a language information' do
    saved_language = FactoryBot.create(:language)
    get language_path(saved_language)
    # check the response http status
    expect(response).to have_http_status '200'
    # check the response data
    json = JSON.parse(response.body, symbolize_names: true)
    data = json[:data]
    expect(saved_language.id).to eq data[:id]
    expect(saved_language.language_name).to eq data[:language_name]
  end

  it 'shows languages information' do
    saved_languages = []
    5.times do
      saved_languages << FactoryBot.create(:language)
    end
    get languages_path
    # check the response http status
    expect(response).to have_http_status '200'
    # check the reponse data
    json = JSON.parse(response.body, symbolize_names: true)
    data_array = json[:data]
    data_array.zip(saved_languages).each do |response_data, saved_data|
      expect(response_data[:id]).to eq saved_data.id
      expect(response_data[:language_name]).to eq saved_data.language_name
    end

  end
end
