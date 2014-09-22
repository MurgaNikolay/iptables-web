class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :hostname
      t.string :token
      t.string :description
      t.datetime :last_access
      t.timestamps
    end
  end
end
