require 'rails_helper'

RSpec.describe Lang, type: :model do
  it "is valid with a language name" do
    lang = Language.new(language_name: "English")
    expect(lang).to be_valid
  end

  it "does not have a name except for string" do
    word_exp = /[a-zA-Z]+/
    lang = Language.new(language_name: 100)
    expect(word_exp === lang.language_name).to_not be true
  end

end
