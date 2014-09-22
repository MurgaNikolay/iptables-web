# for more details see: http://emberjs.com/guides/models/defining-models/

Access.User = DS.Model.extend
  uid: DS.attr('string'),
  name : DS.attr('string'),
  email: DS.attr('string'),
  image: DS.attr('string')
  profile: DS.attr('string')

