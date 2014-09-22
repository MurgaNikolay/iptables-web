class NodesSecurityGroupSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :node_id, :security_group_id
end