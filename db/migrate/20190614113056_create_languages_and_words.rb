class CreateLanguagesAndWords < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :language_name, :null => false
      t.string :created_by
      t.string :last_updated_by
      t.timestamps
    end
    create_table :words do |t|

      t.string :word, :null => false
      t.string :meaning, :null => false
      t.references :word_lang
      t.references :meaning_lang
      t.string :created_by
      t.string :last_updated_by
      t.timestamps
    end
    add_foreign_key :words, :languages, column: :word_lang_id
    add_foreign_key :words, :languages, column: :meaning_lang_id
    
  end
end

