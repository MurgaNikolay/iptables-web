class Node < ActiveRecord::Base

  has_many :ips, :class_name => 'NodeIp'
  has_and_belongs_to_many :security_groups
  has_many :access_rules, as: :access_rulable

  #has_and_belongs_to_many :security_groups
  #has_and_belongs_to_many :access_rules
  # self.include_root_in_json = true
  validates :name, presence: true
  validates :name, uniqueness: true

  def full_access_rules
    access_rules = Array(self.access_rules)
    access_rules.concat(security_groups.map(&:access_rules).flatten)
  end

  def self.create(params)
    params[:token] = Digest::MD5.hexdigest(SecureRandom.urlsafe_base64(100, false)).scan(/.{8}/).join('-') unless params[:token]
    super(params)
  end

  def self.register(params)
    node = find_by(name: params['name'])
    unless node
      node = Node.create(name: params['name'], description: params[:description])
      Array(params[:access_rules]).each do |rule|
        node.access_rules.create({
            protocol: rule[:protocol] || 'all',
            ip: rule[:ip] || node.name,
            port: rule[:port] || nil,
            description: rule[:description] || node.name
          })
      end
      # Allow for groups
      Array(params[:groups_access_rules]).each do |rule|
        group = SecurityGroup.find_by_name_or_id(rule['group'])
        if group
          group.access_rules.create({
              protocol: 'all',
              ip: node.name,
              port: rule[:port] || nil,
              description: rule[:description] || node.name
            })
          group.save
        end
      end
    end

    Array(params[:security_groups]).map do |group|
      group = SecurityGroup.find_by_name_or_id(group)
      node.security_groups << group if group
    end
    node
  end
end
