class AddWhoColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :created_by, :string
    add_column :users, :last_updated_by, :string
    add_column :users, :creatoin_date, :datetime
    add_column :users, :last_updated_date, :datetime 
  end
end
