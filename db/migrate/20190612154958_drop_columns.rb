class DropColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :creatoin_date
    remove_column :users, :last_updated_date
  end
end
