# For more information see: http://emberjs.com/guides/routing/

Access.IndexRoute = Ember.Route.extend
  activate: ->
    @transitionTo('nodes')
