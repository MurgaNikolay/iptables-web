Access.ModalConfirmComponent = Ember.Component.extend(
  actions:
    ok: ->
      @$('.modal').modal('hide');
      @sendAction('ok')
    close: ->
      @$('.modal').modal('hide');
  show: (->
    @$('.modal').modal().on 'hidden.bs.modal', =>
      @sendAction('close')
  ).on('didInsertElement')
)
