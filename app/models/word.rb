class Word < ApplicationRecord
  validates :word, presence: true, uniqueness: {scope: :word_lang_id}
  validates :meaning, presence: true, uniqueness: {scope: :meaning_lang_id}

  belongs_to :word_lang, class_name: 'Language', foreign_key: 'word_lang_id'
  belongs_to :meaning_lang, class_name: 'Language', foreign_key: 'meaning_lang_id'

  validate :language_cannot_be_the_same

  def language_cannot_be_the_same
    if word_lang == meaning_lang
      errors.add(:language, "language cannot be the same")
    end
  end
end
