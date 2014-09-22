# for more details see: http://emberjs.com/guides/models/defining-models/

Access.AccessRule = DS.Model.extend(
  protocol: DS.attr('string')
  ip: DS.attr('string')
  port: DS.attr('string')
  description: DS.attr('string')
  createdAt: DS.attr('date')
  updatedAt: DS.attr('date')
  accessRulable: DS.belongsTo 'accessRulable', polymorphic: true
  inspect: (->
    "id:"+@get('id')+"; ip:"+@get('ip')
  ).property()
)
