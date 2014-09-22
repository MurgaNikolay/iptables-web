class SecurityGroupSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  embed :ids, include: true
  attributes :id, :name, :links
  def links
    {
      :access_rules =>  security_group_access_rules_path(object),
      :nodes =>  security_group_nodes_path(object)
    }
  end
end
