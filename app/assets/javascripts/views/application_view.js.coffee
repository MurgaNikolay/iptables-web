
Access.ApplicationView = Ember.View.extend
  templateName: 'application'
  didInsertElement: ->
    @$().on('click', '.auto_selectable', ->
      if document.selection
        range = document.body.createTextRange();
        range.moveToElementText(@);
        range.select();
      else if window.getSelection
        range = document.createRange();
        range.selectNode(@);
        window.getSelection().addRange(range);

    )
