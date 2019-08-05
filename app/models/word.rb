class Word < ApplicationRecord
  validates :word, presence: true, uniqueness: { scope: :word_lang_id, case_sensitive: false }
  validates :meaning, presence: true, uniqueness: { scope: :meaning_lang_id }

  belongs_to :word_lang, class_name: 'Language', foreign_key: 'word_lang_id'
  belongs_to :meaning_lang, class_name: 'Language', foreign_key: 'meaning_lang_id'

  validate :language_cannot_be_the_same

  class << self
    def search(params)
      if params.present?
        # query_hash = Rack::Utils.parse_nested_query(query)
        valid_query = params.slice(:word, :meaning)
        puts "params: #{params.inspect}"
        puts "valid_query: #{valid_query}"
        puts "except check: #{valid_query.except('word', 'meaning')}"
        if !valid_query.blank? && valid_query.except('word', 'meaning').blank?
          if valid_query['word'].present?
            word = where('word LIKE BINARY ?', "%#{valid_query['word']}%")
          elsif valid_query['meaning'].present?
            word = where('meaning LIKE BINARY ?', "%#{valid_query['meaning']}%")
          end
          word = word.order(:id)
        else
          word = Word.new.errors.add(:query, 'invalid query exists')
          # puts "error: #{word.inspect}"
        end
      else
        word = Word.new.errors.add(:query, 'query does not exist')
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
