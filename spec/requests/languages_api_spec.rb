require 'rails_helper'

RSpec.describe "LanguagesApi", type: :request do
  it "registers a new language" do
    language_params = FactoryBot.attributes_for(:language)
    expect {
    post languages_path, params: {language: language_params}
    }.to change(Language, :count).by(1)
    expect(response).to have_http_status "200"
    expect(Language.last.language_name).to eq language_params[:language_name]
  end

  it "edits a language"
  it "deletes a language"
  it "shows a language information"
  it "shows languages information"
end
