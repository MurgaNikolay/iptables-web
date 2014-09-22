# For more information see: http://emberjs.com/guides/routing/

Access.GroupsGroupRoute = Ember.Route.extend
  model: (params)->
    # here we tell the route to use its parent model
    @store.find('securityGroup', params.group_id);
