# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ar1 =  AccessRule.create(protocol: 'udp', port: 22, ip: '0.0.0.0')
puts ar1.errors.inspect
ar2 =  AccessRule.create(protocol: 'tcp', port: 9200, ip: '0.0.0.0')
ar3 =  AccessRule.create(protocol: 'tcp', port: 1253, ip: '0.0.0.0')

default_sg = SecurityGroup.create(name: 'Default')
default_sg.access_rules << ar1
default_sg.save

default_sg2 = SecurityGroup.create(name: 'Elasticsearch')
default_sg2.access_rules << ar2
default_sg2.save

node = Node.create(hostname: 'localhost', description: '')
node.security_groups << default_sg
node.access_rules << ar3
node.save


node = Node.create(hostname: 'qa.vocvox.com', description: '')
node.security_groups << default_sg2
node.save
