class CreateNodeIps < ActiveRecord::Migration
  def change
    create_table :node_ips do |t|
      t.belongs_to :node
      t.string :ip
      t.timestamps
    end
  end
end
