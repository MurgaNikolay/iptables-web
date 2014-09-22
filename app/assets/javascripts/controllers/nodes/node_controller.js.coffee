# for more details see: http://emberjs.com/guides/controllers/

# our nested user route will render only a single user at a time so it's an ObjectController
Access.NodesNodeController = Ember.ObjectController.extend(Access.HasAccessRulesEditableMixin,
  findGroup: (->
    return (term, callback)=>
      #console.log(term, callback)
      @get('store').find('security_group', $.extend(term, {node: @get('model').get('id') })).then (model)->
        callback(model.map (i)->
            {
              label: i.get('name'),
              id: i.get('id')
            }
        )
  ).property()

  searchGroup: false,
  actions:
    searchGroup: ->
      @set('searchGroup', true)
    closeSearchGroup:->
      console.log('closeSearchGroup')
      @set('searchGroup', false)
    saveGroup: (_, item)->
      @store.createRecord('NodesSecurityGroup', {
        securityGroupId: item.id,
        nodeId: @get('model').get('id')
      }).save().then =>
        @get('model').reload()
        @set('searchGroup', false)
    deleteGroup: (group)->
      node = @get('model')
      @get('store').find('nodes_security_group', {
        node_id: node.get('id'),
        security_group_id: group.get('id')
      }).then (model)=>
        link = model.get('firstObject')
        link.deleteRecord()
        link.save()
        @get('model').reload()
)