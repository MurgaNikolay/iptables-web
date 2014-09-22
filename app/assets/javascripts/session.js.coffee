Access.ApplicationRouteMixin = Ember.Mixin.create
  setupController: (controller)->
    @_super(controller)
    controller.set('current_user', @get('current_user'))
  loggedIn: false,
  current_user: (->
    @store.find('user', 'current')
  ).property('loggedIn')
  actions:
    error: (error, transition) ->
      @_super(error, transition)
      console.log(error, transition)
      if error.status = 401
        @set('savedTransition', @controller.get('currentPath'))
        @set('loggedIn', false)
        @controller.set('current_user', null)
        @transitionTo('login')

    logout: ->
      @set('loggedIn', false)
      @set('savedTransition', @controller.get('currentPath'))
      Ember.$.ajax(
        url: '/sessions/1',
        type: 'DELETE'
      ).then =>
        @controller.set('current_user', null)
        @transitionTo('login')

    authenticate: ()->
      @set('loggedIn', true)
      @controller.set('current_user', @get('current_user'))
      if @get('savedTransition')
        @transitionTo(@get('savedTransition'))

Access.ApplicationControllerMixin = Ember.Mixin.create()

