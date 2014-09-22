Access.JqueryAutocompleteComponent = Ember.Component.extend(
  tagName: "input"
#  attributeBindings: ["placeholder"]
  didInsertElement: ->
    element = @$().autocomplete(
      source: @get('source')
      minLength: @get('minLength')
      messages:
        noResults: '',
        results: ->
      select: (event, ui) =>
        @sendAction('action', @get('action'), ui.item) if ui.item.label
        return
      open: =>
        @$().removeClass("ui-corner-all").addClass "ui-corner-top"
        return

      close: =>
        @$().removeClass("ui-corner-top").addClass "ui-corner-all"
        return
    )
    return
)