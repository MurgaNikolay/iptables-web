class AddIndexNodesName < ActiveRecord::Migration
  def change
    add_index :nodes, :name, unique: true
  end
end
