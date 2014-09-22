# for more details see: http://emberjs.com/guides/models/defining-models/

Access.AccessRuleControllerMixin = Ember.Mixin.create
  protocols: [
    {label: 'ALL', value: 'all'},
    {label: 'TCP', value: 'tcp'},
    {label: 'UDP', value: 'udp'},
    {label: 'ICMP', value: 'icmp'}
  ],

  showForm:(->
    @get('editMode') || !@get('model').get('id')
  ).property('editMode', 'model.id')

  editMode: false
  actions:
    save: ->
      @get('model').save().then (=>
        @set('editMode', false)
        return
      ), ((response)=>
        return false
      )
    cancel: ->
      @set('editMode', false)

    edit: ->
      @set('editMode', true)

