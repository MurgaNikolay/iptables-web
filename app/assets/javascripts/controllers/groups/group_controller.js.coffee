# for more details see: http://emberjs.com/guides/controllers/

# our nested user route will render only a single user at a time so it's an ObjectController
Access.GroupsGroupController = Ember.ObjectController.extend(Access.HasAccessRulesEditableMixin, Access.WithNodeAutocompleteMixin)
