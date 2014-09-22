# for more details see: http://emberjs.com/guides/models/defining-models/

Access.SecurityGroup = DS.Model.extend
  name: DS.attr('string'),
  createdAt: DS.attr('date'),
  accessRules: DS.hasMany('accessRule'),
#  nodes: DS.hasMany('node')

