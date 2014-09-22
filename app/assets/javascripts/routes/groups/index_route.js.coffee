# For more information see: http://emberjs.com/guides/routing/

Access.GroupsIndexRoute = Ember.Route.extend
  model: ->
    # here we tell the route to use its parent model
    @store.find('securityGroup');