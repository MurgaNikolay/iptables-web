# for more details see: http://emberjs.com/guides/models/defining-models/

Access.AccessRulesControllerMixin = Ember.Mixin.create
  confirmDelete: false
  modelClass: ->
    throw new Error("You need to override modelClass property")
  actions:
    add: ->
      @pushObject(@store.createRecord(@get('modelClass'), {protocol: 'all' }))
    delete: (rule)->
      @set('confirmDelete', rule)
    deleteConfirm: ->
      @get('confirmDelete').deleteRecord()
      @get('confirmDelete').save()
      @set('confirmClose',  false)
    deleteCancel: ->
      @set('confirmDelete',  false)
