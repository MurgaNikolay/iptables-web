# For more information see: http://emberjs.com/guides/routing/

Access.NodesNodeRoute = Ember.Route.extend
  model: (params) ->
    @store.find('node', params.node_id)

  actions:
    refreshNode:->
      console.log('refresh')
      @refresh()
    goBack: ->
      @transitionTo('users');

