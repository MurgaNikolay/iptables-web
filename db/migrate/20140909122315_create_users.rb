class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :image, null: true
      t.string :profile, null: true
      t.string :uid, limit: 25
      t.string :provider, limit: 20, null: true
      t.string :oauth_token, null: true
      t.datetime :oauth_expires_at, null: true
      t.timestamps
    end
    add_index :users, :email, { unique: true }
    add_index :users, [:provider, :uid], {unique: true}
  end
end
