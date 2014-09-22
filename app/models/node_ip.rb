require 'resolv'
class NodeIp < ActiveRecord::Base
  validates :ip, presence: true, uniqueness: false,
    :format => { :with => Resolv::IPv4::Regex }
  belongs_to :node
end

