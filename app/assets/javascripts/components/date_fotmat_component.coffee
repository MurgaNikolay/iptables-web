Access.DateFormatComponent = Ember.Component.extend(
  tagName: "span"
  didInsertElement: ->
    @$().html(moment(@get('value')).format(@get('format')))
)