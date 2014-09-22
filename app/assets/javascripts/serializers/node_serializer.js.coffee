#Access.ApplicationSerializer = DS.ActiveModelSerializer

Access.NodeSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs:
    accessRules: {serialize: 'records', deserialize: 'ids'},
    securityGroups: {serialize: 'records', deserialize: 'ids'}
})
#  {
#  serializeHasMany: (record, json, relationship) ->
#    console.log('serializeHasMany')
#    console.log('serializeHasMany')
#    @_super(record, json, relationship)
#    console.log('record', record)
#    console.log('json', json)
#    console.log('relationship', relationship)
#    key = relationship.key
#    json[key] = @get(record, key).mapBy('id')
#  })