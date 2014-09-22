# for more details see: http://emberjs.com/guides/controllers/

Access.NodesIndexController = Em.ArrayController.extend(
  sortProperties: ["id"]
  sortAscending: true
  actions:
    deleteNode: (node)->
      @set('modelForDelete', node)

    confirmOk: ->
      @get('modelForDelete').deleteRecord()
      @get('modelForDelete').save()

    confirmClose: ->
      @set('modelForDelete',  false)

    saveNode: (event)->
      if @get('createMode')
        node = @store.createRecord('node', {
          name: @get('nodeName')
          description: @get('nodeDescription')
        });
        node.save()
      else
        node = @get('currentNode')
        node.save() if node
      @send('cancelNode')
    editNode: (node) ->
      @send('cancelNode')
      node.set('editMode', true)
      @set('currentNode', node)
      return false
    createNode: ->
      @send('cancelNode')
      @set('createMode', true)
      return false
    cancelNode: ->
      if currentNode = @get('currentNode')
        currentNode.set('editMode', false)
      @set('createMode', false)
  nodesCount: (->
    @get "model.length"
  ).property("@each")
)
