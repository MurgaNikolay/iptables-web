class CreateNodesSecurityGroups < ActiveRecord::Migration
  def change
    create_table :nodes_security_groups do |t|
      t.integer :node_id
      t.integer :security_group_id
    end
    add_index :nodes_security_groups, [:node_id, :security_group_id]
    add_index :nodes_security_groups, :node_id
  end
end
