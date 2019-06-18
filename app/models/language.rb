class Language < ApplicationRecord
  validates :language_name, presence: true
  has_many :words
end
