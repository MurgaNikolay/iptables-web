Access.AccessRulesController = Ember.ArrayController.extend
  confirmDelete: false
  itemController: 'accessRule'

  selected: (->
    @filterProperty('checked', true)
  ).property('@each.checked')

  isEditing: (->
    @filterProperty('isEditing', true).get('length') > 0
  ).property('@each.isEditing')

  isAllSelected: (->
    @get('selected.length') == @get('length') && @get('length') > 0
  ).property('selected')

  isChecked: ((key, value)-> #for checkbox
    unless value == undefined #check all by click
      this.forEach (itemController)=>
        itemController.set('checked', value)
    else
      @get('isAllSelected')
  ).property('isAllSelected')

  isSemiSelected: (->
    @get('selected.length') != @get('length') && @get('selected.length') > 0
  ).property('selected')

  isSelected: (->
    @get('selected.length') > 0
  ).property('selected')

  isNotSelected: Ember.computed.not('isSelected')

  makeNewAsChecked: (->
    @filterProperty('model.isNew', true).forEach (item) ->
      item.set('checked', true)

  ).observes('@each.isNew')

  setEditOnEditModeAndChecked: (->
    if @get('isEditing')
      @filterProperty('checked', true).forEach (controller)->
        controller.send('edit')

      @filterProperty('checked', false).forEach (controller)->
        controller.send('cancel')
  ).observes('selected')

  isRemoveDisabled: (->
    @get('selected.length') == 0 || @get('isEditing')
  ).property('selected', 'isEditing')

  actions:
    deleteSelected: ->
      items = @get('selected')
      @set('confirmDelete', items)

    edit: ->
      @filterProperty('checked', true).forEach (itemController) =>
        itemController.send('edit')

    cancelEdit: ->
      #remove new models
      @removeObjects(@filterProperty('model.isNew', true))
      @filterProperty('isEditing', true).forEach (itemController) =>
        itemController.send('cancel')

    saveEdit: ->
      @filterProperty('isEditing', true).forEach (itemController) =>
        itemController.send('save')

    delete: (rule)->
      @set('confirmDelete', [rule])

    add: ->
      @pushObject(@store.createRecord('accessRule', {protocol: 'all' }))

    deleteConfirm: ->
      @get('confirmDelete').forEach (controller) ->
        controller.get('model').destroyRecord()

    deleteCancel: ->
      @set('confirmDelete',  false)
