# for more details see: http://emberjs.com/guides/models/defining-models/

Access.AccessRulable = DS.Model.extend(
#  accessRulable:    DS.attr 'boolean'
  accessRules:  DS.hasMany 'accessRule', async: true, polymorphic: true
)
