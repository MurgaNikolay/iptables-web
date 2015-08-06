#= require jquery
#= require jquery-ui
#= require moment
#= require handlebars
#= require ember
#= require bootstrap
#= require ember-data
#= require_tree ./lib
#= require_self
#= require access.js.coffee

# for more details see: http://emberjs.com/guides/application/
window.Access = Ember.Application.create(
  LOG_TRANSITIONS: true,
  LOG_TRANSITIONS_INTERNAL: true,
  rootElement: '#access_application'
)

