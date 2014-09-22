# for more details see: http://emberjs.com/guides/controllers/

Access.NodesIndexController = Em.ArrayController.extend(
  sortProperties: ["hostname"]
  sortAscending: true
  actions:
    delete: (node)->
      console.log(node)
      node.deleteRecord();
      node.save();
      alert('nodes')
    rehash: (node)->
#      node.rehash()
      console.log('rehash', node)
    add: ->
      console.log('Add Node')
  nodesCount: (->
    @get "model.length"
  ).property("@each")
)

