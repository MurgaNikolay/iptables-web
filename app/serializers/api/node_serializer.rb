class Api::NodeSerializer < ActiveModel::Serializer
  attributes :id, :token, :name, :created_at
end
