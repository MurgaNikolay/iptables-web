class Api::AccessRuleSerializer < ActiveModel::Serializer
  # embed :ids, include: true
  attributes :id, :protocol, :ip, :resolved_ips, :port, :protocol, :description, :updated_at#, :created_at
end
