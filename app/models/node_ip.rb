require 'resolv'
class NodeIp < ActiveRecord::Base
  validates :ip, presence: true, uniqueness: false,
    :format => { :with => Resolv::IPv4::Regex }
  belongs_to :node

  def ==(other_node_ip)
    return false unless other_node_ip.is_a?(NodeIp)
    interface == other_node_ip.interface
  end

  def ===(other_node_ip)
    return false unless other_node_ip.is_a?(NodeIp)
    interface == other_node_ip.interface && ip == other_node_ip.ip
  end
end

