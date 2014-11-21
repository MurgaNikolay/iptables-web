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
end
