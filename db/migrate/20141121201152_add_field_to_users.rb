class AddFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :internal, :boolean
    add_column :users, :access_key, :string
    add_column :users, :access_token, :string
    add_index :users, :access_key
  end
end
