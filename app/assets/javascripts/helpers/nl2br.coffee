Ember.Handlebars.registerBoundHelper 'nl2br', (text) ->
  breakTag = '<br />'
  new (Handlebars.SafeString)((text + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2'))
