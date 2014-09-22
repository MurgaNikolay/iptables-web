module Mixin
  module IpTools
    def is_ip?(ip)
      !!IPAddr.new(ip)
    rescue
      false
    end
  end
end
