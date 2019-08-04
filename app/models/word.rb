class Word < ApplicationRecord
  validates :word, presence: true, uniqueness: { scope: :word_lang_id }
  validates :meaning, presence: true, uniqueness: { scope: :meaning_lang_id }

  belongs_to :word_lang, class_name: 'Language', foreign_key: 'word_lang_id'
  belongs_to :meaning_lang, class_name: 'Language', foreign_key: 'meaning_lang_id'

  validate :language_cannot_be_the_same

  class << self
    def search(query)
      if query.present?
        query_hash = Rack::Utils.parse_nested_query(query)
        if query_hash.except('word', 'meaning').nil?
          if query_hash['word'].exists?
            word = where('word LIKE ?', `%#{query_hash['word']}%`)
          elsif query_hash['meaning'].exists?
            word = where('meaning LIKE ?', `%#{query_hash['meaning']}%`)
          end
          word = rel.order('id')
        else
          word.errors.add(:query, 'invalid query exists')
        end
      else
        word.errors.add(:query, 'query does not exist')
      end
      word
    end
  end

  def language_cannot_be_the_same
    if word_lang == meaning_lang
      errors.add(:language, 'language cannot be the same')
    end
  end
end
