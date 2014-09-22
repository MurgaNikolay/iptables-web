# for more details see: http://emberjs.com/guides/models/defining-models/

Access.AccessRuleMixin = Ember.Mixin.create
  protocol: DS.attr('string')
  ip: DS.attr('string')
  port: DS.attr('string')
  description: DS.attr('string')
  createdAt: DS.attr('date')
  updatedAt: DS.attr('date')
