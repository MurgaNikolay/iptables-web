class AccessRuleSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :protocol, :ip, :port, :protocol, :description, :updated_at, :created_at
  # has_many_and_belongs_to :nodes
  # has_many :security_groups
end