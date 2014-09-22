class SecurityGroupSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :name
  has_many :access_rules
end