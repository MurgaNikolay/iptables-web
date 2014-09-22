class AddMaskAndInterface < ActiveRecord::Migration
  def change
    add_column :node_ips, :netmask, :string
    add_column :node_ips, :interface, :string
  end
end
