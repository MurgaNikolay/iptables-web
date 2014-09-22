# For more information see: http://emberjs.com/guides/routing/
  Access.NodesIndexRoute = Ember.Route.extend
    model: ->
      @store.find('node');

#    actions:
#        @toggleProperty('deleteMode');
#      cancelDelete: ->
#        @set('deleteMode', false);
#      confirmDelete: ->
#        @get('model').deleteRecord()
#        @get('model').save()
#        @transitionToRoute('users')
#        @set('deleteMode', false)