
Access.HasAccessRulesEditableMixin = Ember.Mixin.create(
  {
  protocols: [
    {label: 'ALL', value: 'all'},
    {label: 'TCP', value: 'tcp'},
    {label: 'UDP', value: 'udp'},
    {label: 'ICMP', value: 'icmp'}
  ],

  addRule: false,
  actions:
    removeRule: (rule)->
      rule.deleteRecord()
      rule.save().then =>
        @get('model').get('accessRules').removeObject(rule)
    addRule: ->
      @set('addRule', true)
    cancelRule: ->
      @set('addRule', false)
    createRule: ->
      rule = @store.createRecord('accessRule', {
        ip: @get('rule_ip'),
        protocol: @get('rule_protocol').value,
        port: @get('rule_port'),
        description: @get('rule_description')
      });

      @get('model').get('accessRules').pushObject(rule)
      @get('model').save().then =>
        @get('model').reload()
})
