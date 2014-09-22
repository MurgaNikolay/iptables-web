Access.GroupsIndexController = Ember.ArrayController.extend
  sortProperties: ["name"]
  sortAscending: true
  confirmDelete: false
  createMode: false
  confirmAction: false
  actions:
    deleteGroup: (group)->
      @set('modelForDelete', group)

    confirmOk: ->
      @get('modelForDelete').deleteRecord()
      @get('modelForDelete').save()

    confirmClose: ->
      @set('modelForDelete',  false)

    rehash: (group)->
      console.log('rehash', group)

    saveGroup: (event)->
      if @get('createMode')
        securityGroup = @store.createRecord('securityGroup', {
          name: @get('groupName')
        });
        securityGroup.save()
      else
        group = @get('currentGroup')
        group.save() if group
      @send('cancelGroup')
    editGroup: (group) ->
      @send('cancelGroup')
      group.set('editMode', true)
      @set('currentGroup', group)
      return false
    createGroup: ->
      @send('cancelGroup')
      @set('createMode', true)
      return false
    cancelGroup: ->
      if currentGroup = @get('currentGroup')
        currentGroup.set('editMode', false)
      @set('createMode', false)
