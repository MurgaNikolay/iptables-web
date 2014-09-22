# require 'activerecord-import'
require 'mixin/country'
class SecurityGroup < ActiveRecord::Base
  has_and_belongs_to_many :access_rules
  has_and_belongs_to_many :nodes

end
