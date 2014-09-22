# for more details see: http://emberjs.com/guides/models/defining-models/

Access.Node = DS.Model.extend
  hostname: DS.attr('string'),
  description : DS.attr('string'),
  ips: DS.attr('string'),
  createdAt: DS.attr('date')
  updatedAt: DS.attr('date')
  lastAccess: DS.attr('date')
  token: DS.attr('string')
  accessRules: DS.hasMany('accessRule')
  securityGroups: DS.hasMany('securityGroup')
