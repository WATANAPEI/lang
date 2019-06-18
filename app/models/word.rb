class Word < ApplicationRecord
  validates :word, presence: true, uniqueness: {scope: :word_lang_id}
  validates :meaning, presence: true, uniqueness: {scope: :meaning_lang_id}

  belongs_to :word_lang, class_name: 'Language', foreign_key: 'word_lang_id'
  belongs_to :meaning_lang, class_name: 'Language', foreign_key: 'meaning_lang_id'

end
