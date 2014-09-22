class CreateAccessRules < ActiveRecord::Migration
  def change
    create_table :access_rules do |t|
      t.string  :protocol
      t.string  :port
      t.string  :ip
      t.string  :description
      t.references :access_rulable, polymorphic: true
      t.timestamps
    end
  end
end
