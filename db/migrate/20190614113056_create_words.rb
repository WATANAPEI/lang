class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|

      t.string :word, :null => false
      t.string :meaning, :null => false
      t.string :word_lang
      t.string :meaning_lang
      t.string :created_by
      t.string :last_updated_by
      t.timestamps
    end
  end
end
