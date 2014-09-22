# for more details see: http://emberjs.com/guides/views/

Access.AccessRulesView = Ember.View.extend
  templateName: 'access_rules'
  readOnly: false
  isReadOnly: Ember.computed.alias('readOnly')

  showControls: (->
    return false unless @$()
#    if @get('controller.selected.length') > 0
#      @$('.rules_groups_actions').prop('disabled', false)
#    else
#      @$('.rules_groups_actions').prop('disabled', 'disabled')
  ).observes('controller.selected.length')








