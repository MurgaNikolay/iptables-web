# for more details see: http://emberjs.com/guides/models/defining-models/

Access.Node = Access.AccessRulable.extend
  name: DS.attr('string'),
  hostname: DS.attr('string'),
  description : DS.attr('string'),
  ips: DS.attr(),
  createdAt: DS.attr('date'),
  updatedAt: DS.attr('date'),
  lastAccess: DS.attr('date'),
  token: DS.attr('string'),
  securityGroups: DS.hasMany('securityGroup', async: true)
