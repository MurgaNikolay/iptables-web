# require 'activerecord-import'
require 'mixin/country'
class AccessRule < ActiveRecord::Base
  extend Mixin::Country
  belongs_to :access_rulable, polymorphic: true
  # attr_accessor :port
  validates_presence_of :ip
  validates_inclusion_of :protocol, in: %w(all udp tcp icmp), message: 'valid values ​​are: all, udp, tcp, icmp'
  validate :ip_or_hostname
  validate :validate_port

  PORTS = {
    https: 443,
    http: 80,
    ssh: 22,
    smtps: 465,
    smtp: 25,
    imaps: 993,
    imap: 143,
    pop3s: 995,
    pop3: 110,
    elasticsearch: 9200,
    mongodb: 27017,
    pptp: 1723,
    openvpn: 1194,
    mysql: 3306,
    postgresql: 5432,
    beanstalkd: 11300,
    memcache: 11211,
    dns: 53
  }

  def port=(value)
    value = replace_ports(value) if value && !value.to_s.empty?
    super(value)
  end

  def validate_port
    return if port.to_s.empty?
    ports = port.to_s.split(/,|:/)
    ports.all? do |port|
      port = PORTS[port.to_sym] if PORTS[port.to_sym]
      errors.add(:port, "Port #{port} must be in range 0..65535") unless port.to_i >= 0 && port.to_i <= 65535
      port.to_s.match('[0-9]')
    end || errors.add(:port, 'Port must be a number')

    errors.add(:port, 'Maximum number of ports can not be more than 15') if ports.size > 15
  end

  def ip_or_hostname
    return if ip.to_s.empty?
    ip_and_mask = ip.split('/')
    #chek ip format

    if Resolv::IPv4::Regex.match(ip_and_mask.first) || ip_and_mask.size > 2
      if ip_and_mask.size == 2 && !(0..32).include?(ip_and_mask.last.to_i)
        errors.add(:ip, 'Wrong subnet mask')
      else
        return true
      end
    end

    #try to find Node
    if Node.find_by(name: ip)
      errors.delete(:ip)
      return true
    end

    cant_resolve = false
    begin
      addresses = Resolv.getaddresses(ip)
      cant_resolve = true unless addresses.size > 0
    rescue
      cant_resolve = true
    end

    if cant_resolve
      errors.add(:ip, "Can't resolve ip by name #{ip}")
    else
      errors.delete(:ip)
    end
  end

  def resolved_ips
    ip_and_mask = ip.split('/')
    return [ip] if Resolv::IPv4::Regex.match(ip_and_mask.first)
    node = Node.find_by(name: ip)
    return node.ips.map(&:ip) if node && node.ips.size > 0
    Resolv.getaddresses(ip)
  end

  def replace_ports(value)
    value = value.to_s
    PORTS.each do |service, port|
      value.gsub!(service.to_s, port.to_s)
    end
    value
  end
end
