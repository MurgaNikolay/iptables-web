Access.WithNodeAutocompleteMixin = Ember.Mixin.create
  nodeAutocomplete: (->
#    console.log('nodeAutocomplete')
    return (term, callback)=>
      @get('store').find('node', $.extend(term, {node: @get('model').get('id') })).then (model)->
        callback(model.map (i)->
            {
              label: i.get('name'),
              id: i.get('id')
            }
        )
  ).property()

