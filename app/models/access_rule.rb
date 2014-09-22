# require 'activerecord-import'
require 'mixin/country'
class AccessRule < ActiveRecord::Base
  has_and_belongs_to_many :nodes
  has_and_belongs_to_many :security_groups

  # validates :ip, uniqueness: true
  extend Mixin::Country
  class << self
    def create_by_params(params)
      errors = false
      begin
        addresses = Resolv.getaddresses(params[:ip])
      end
      puts addresses.size
      return {ip: ['is not valid']} if addresses.size == 0
      params[:hostname] = params[:ip] unless is_ip?(params[:ip])
      addresses.each do |address|
        access_list = AccessList.new
        access_list.hostname = params[:hostname]
        access_list.ip = address
        access_list.country = country(address)
        access_list.hostname = params[:hostname]
        access_list.client_ip = params[:request].remote_ip
        access_list.client_country = country(params[:request].remote_ip)
        access_list.user_id = params[:user].id
        access_list.zone_id = params[:zone_id]
        # access_list.group_id = ''
        unless access_list.valid?
          errors ||= {}
          errors.merge! access_list.errors
          next
        end
        access_list.save!
      end
      errors
    end

    def is_ip?(ip)
      !!IPAddr.new(ip)
    rescue
      false
    end


  end

  def to_log
    log = []
    log << "IP: #{ip}"
    log << "IP country: #{country}"
    log << "Hostname: #{hostname}"
    log << "Client IP: #{client_email}"
    log << "Client email: #{client_email}"
    log << "Client country: #{client_country}"
    log.join(',')
  end
end
