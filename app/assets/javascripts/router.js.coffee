# For more information see: http://emberjs.com/guides/routing/
Access.Router.map ->
  # this route will be our collection of users
  @resource 'nodes', path: '/nodes', ->
    @route 'node',  path: '/:node_id'
    @route 'install',  path: '/:node_id/install'

  @resource 'groups', path: '/groups', ->
    @route 'group', path: '/:group_id'
    @route 'create', path: '/create'

  @route 'login', path: '/login'

  @route "missing",
    path: "/*path"
  return

Access.ApplicationSerializer = DS.ActiveModelSerializer.extend()

Access.Router.reopen({
  rootURL: '/nodes/'
});

# this handles wrong routes - you could use it to redirect to a 404 route or like here to redirect to the index page
Access.MissingRoute = Em.Route.extend
  redirect: ->
    this.transitionTo('nodes')
