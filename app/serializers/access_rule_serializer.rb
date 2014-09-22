class AccessRuleSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :protocol, :ip, :port, :protocol, :description, :updated_at, :created_at
end
