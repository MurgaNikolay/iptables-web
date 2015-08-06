class NodeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  embed :ids, include: true
  attributes :id, :name, :hostname,
    :description, :ips, :created_at,
    :updated_at, :last_access,
    :token, :links, :report, :has_errors

  def links
    {
      :access_rules =>  node_access_rules_path(object),
      :security_groups =>  node_security_groups_path(object)
    }
  end

  def last_access
    object.last_access.to_i
  end

  def ips
    object.ips.map(&:ip)
  end
end
