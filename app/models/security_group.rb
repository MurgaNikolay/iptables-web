# require 'activerecord-import'
require 'mixin/country'
class SecurityGroup < ActiveRecord::Base
  has_many :access_rules, as: :access_rulable
  has_and_belongs_to_many :nodes
end
