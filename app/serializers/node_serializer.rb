class NodeSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :hostname, :description, :ips, :created_at,:updated_at, :token
  has_many :access_rules
  has_many :security_groups
end