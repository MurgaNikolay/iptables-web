# for more details see: http://emberjs.com/guides/models/defining-models/

Access.SecurityGroup = Access.AccessRulable.extend
  name: DS.attr('string')
  createdAt: DS.attr('date')
  nodes:  DS.hasMany 'node', async: true

