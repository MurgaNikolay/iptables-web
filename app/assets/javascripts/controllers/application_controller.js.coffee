
Access.ApplicationController = Ember.ArrayController.extend(Access.ApplicationControllerMixin,
  breadcrumbs: []
  watchCurrentPath: (->
    @send "setCrumbs"
    return
  ).observes("currentPath")
  actions:
    currentPathDidChange: ->
      @send "setCrumbs"
      return
    setCrumbs: ->
      # BEWARE:
      # This is some super hacky, non-public API shit right here
      crumbs = []
      # Clear out the current crumbs
      @get("breadcrumbs").clear()
      # Get all the route objects
      routes = @container.lookup("router:main").get("router.currentHandlerInfos")
      # Get the route name, and model if it has one
      routes.forEach (route, i, arr) ->
        # Ignore index routes etc.
        name = route.name
        return  if name.indexOf(".index") isnt -1 or name is "application"
        crumb = Ember.Object.create(
          route: route.handler.routeName
          name: route.handler.routeName
          model: null
        )
        # If it's dynamic, you need to push in the model so we can pull out an ID in the link-to
        if route.isDynamic
          crumb.setProperties
            model: route.handler.context
            name: route.handler.context.get("name")
        # Now push it to the crumbs array
        crumbs.pushObject crumb
        return
      @set "breadcrumbs", crumbs
      # Set the last item in the breadcrumb to be active
      @get("breadcrumbs.lastObject").set "active", true
      return
)
