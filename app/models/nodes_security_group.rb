class NodesSecurityGroup < ActiveRecord::Base
  has_many :nodes
  has_many :security_groups
end
