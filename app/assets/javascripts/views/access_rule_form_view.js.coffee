
Access.AccessRuleFotmView = Ember.View.extend
  templateName: 'access_rule_form'
  tagName: 'tr'
  classNames: ['form-inline']

  didInsertElement: ->
    @_super();
    $('#'+@elementId).find('input.ip_address').mask('0ZZ.0ZZ.0ZZ.0ZZ/0Z', {
      placeholder: "___.___.___.___/__",
      translation:  {'Z': {pattern: /[0-9]/, optional: true}}});
