class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :image, null: false
      t.string :profile, null: false
      t.string :uid, limit: 25
      t.string :provider, limit: 20
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.timestamps
    end
    add_index :users, :email, { unique: true }
    add_index :users, [:provider, :uid], {unique: true}
  end
end
