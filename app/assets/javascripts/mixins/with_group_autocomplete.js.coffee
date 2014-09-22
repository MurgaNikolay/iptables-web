Access.WithGroupAutocompleteMixin = Ember.Mixin.create
  groupAutocomplete: (->
    return (term, callback)=>
      #console.log(term, callback)
      @get('store').find('security_group', $.extend(term, {node: @get('model').get('id') })).then (model)->
        callback(model.map (i)->
            {
            label: i.get('name'),
            id: i.get('id')
            }
        )
  ).property()
