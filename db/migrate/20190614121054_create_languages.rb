class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :language_name, :null => false
      t.string :created_by
      t.string :last_updated_by
      t.timestamps
    end
  end
end
