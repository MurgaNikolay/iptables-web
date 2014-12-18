Access.AccessRuleController = Ember.ObjectController.extend(
  Access.WithNodeAutocompleteMixin,
  needs: 'accessRules'
#  init: ->
#    @_super()

  protocols: [
    {label: 'ALL', value: 'all'},
    {label: 'TCP', value: 'tcp'},
    {label: 'UDP', value: 'udp'},
#    {label: 'ICMP', value: 'icmp'}
  ],

  isEditing: (->
    @get('editMode') || !@get('model').get('id')
  ).property('editMode', 'model.id')

  editMode: false
  actions:
    save: ->
      @get('model').save().then (=>
        @set('editMode', false)
        @set('checked', false)
        return
      ), ((response)=>
        return false
      )
    cancel: ->
      return unless @get('isEditing')
      @set('editMode', false)
      @get('model').deleteRecord() unless @get('model.id')
    remove: ->
      @get('model').deleteRecord()
      @get('model').save()
    editOnDblClick: ->
#      @set('checked', true)

    edit: ->
      @set('editMode', true)
)
