# require 'activerecord-import'
require 'mixin/country'
class SecurityGroup < ActiveRecord::Base
  has_many :access_rules, as: :access_rulable
  has_and_belongs_to_many :nodes

  def self.find_by_name_or_id(name_or_id)
    SecurityGroup.where('name = ? OR id = ?', name_or_id.to_s.camelize, name_or_id.to_i).first
  end
end
