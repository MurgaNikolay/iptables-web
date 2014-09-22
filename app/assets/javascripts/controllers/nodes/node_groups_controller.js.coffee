# for more details see: http://emberjs.com/guides/controllers/

# our nested user route will render only a single user at a time so it's an ObjectController
Access.NodesNodeGroupsController = Ember.ArrayController.extend(
  Access.WithGroupAutocompleteMixin,
  searchGroup: false
  actions:
    searchGroup: ->
      @set('searchGroup', true)
    closeSearchGroup: ->
      @set('searchGroup', false)
    saveGroup: (_, item)->
      return unless item
      node = @get('parentController.model')
      @store.createRecord('nodesSecurityGroup', {
        securityGroupId: item.id,
        nodeId: node.get('id')
      }).save().then =>
        node.get('securityGroups').reload()
        @set('searchGroup', false)
    deleteGroup: (group)->
      node = @get('parentController.model')
      @get('store').find('nodes_security_group', {
        node_id: node.get('id'),
        security_group_id: group.get('id')
      }).then (model) =>
        link = model.get('firstObject')
        link.deleteRecord()
        link.save().then =>
          @removeObject(group)
)
