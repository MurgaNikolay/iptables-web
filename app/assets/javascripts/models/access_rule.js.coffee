# for more details see: http://emberjs.com/guides/models/defining-models/

Access.AccessRule = DS.Model.extend
  protocol: DS.attr('string'),
  ip: DS.attr('string'),
  port: DS.attr('string'),
  description: DS.attr('string'),
  createdAt: DS.attr('date'),
  updatedAt: DS.attr('date'),
  nodes: DS.hasMany('node')


  #id": 2,
#"protocol": "udp",
#"port": "22",
#"ip": "0.0.0.0",
#"created_at": "2014-09-09T18:21:46.000Z",
#"updated_at": "2014-09-09T18:21:46.000Z"
