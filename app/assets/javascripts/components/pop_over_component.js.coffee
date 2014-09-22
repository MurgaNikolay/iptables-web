console.log('PopOverComponent')
Access.PopOverComponent = Ember.Component.extend(
  content: '',
  triggerSelector: 'input',
  triggerName: 'focus',
  position: 'top',
  didInsertElement: ->
    content = @get('content')
    console.log(content)
    return unless content

    if @$.isArray(content)
      content = content.join("\n")

#    trigger = @$().prev()
#    console.log(trigger)

#    console.log('------------')
#    console.log(@$())
#    console.log(@get('content'))
#    console.log(@$())
#    @$().appnd('<span></span>')
#    $(@get('selector')).popover
#      html: true,
#      content: =>
#        $(@contentSelector).html()
)

