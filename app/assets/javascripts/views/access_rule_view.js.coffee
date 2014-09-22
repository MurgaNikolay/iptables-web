
Access.AccessRuleView = Ember.View.extend
  templateName: 'access_rule'
  tagName: 'tr'
  classNameBindings: ['controller.model.isSaving:loading']

  classNames: ['form-inline']
  readOnly: false

  isReadOnly: (->
    @get('view.readOnly') || @get('parentView.readOnly')
  ).property('parentView.readOnly', 'readOnly')

#  doubleClick: ->
#    if (window.getSelection)
#      window.getSelection().removeAllRanges();
#    else if (document.selection)
#      document.selection.empty();
#    @get('controller').send('editOnDblClick') unless @get('isReadOnly')

  isValidChanged: (->
    errors = @get('controller.model.errors')
    if errors.get('isEmpty')
      @$('input,select').popover('destroy') if @$()
    else
      selector = @$('input,select')
      selector.each (index, element) =>
        element = @$(element)
        if name = element.attr('name')
          if messages = errors.get(name)
            messages =  messages.map (o)->
              return o.message.camelize()
            element.popover(
              placement: 'top',
              trigger: 'focus',
              html: true,
              content: messages.join("<br>")
            )
            element.popover('show') if element.is(':focus')
  ).observes('controller.model.errors.[]')

  willDestroyElement: ->
    @$('input,select').popover('destroy')
