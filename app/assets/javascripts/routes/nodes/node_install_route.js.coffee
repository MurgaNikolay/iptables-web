# For more information see: http://emberjs.com/guides/routing/

Access.NodesInstallRoute = Ember.Route.extend
  model: (params) ->
    @store.find('node', params.node_id)

  actions:
    goBack: ->
      @transitionTo "node"
      return