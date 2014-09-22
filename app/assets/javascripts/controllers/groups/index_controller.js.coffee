
Access.GroupsIndexController = Ember.ArrayController.extend
  sortProperties: ["name"]
  sortAscending: true
  actions:
    destroy: (group)->
      group.deleteRecord();
      group.save();
    rehash: (node)->
      console.log('rehash', node)
    add: ->
      console.log('Add Node')
