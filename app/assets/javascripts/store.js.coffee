# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

#Access.ApplicationAdapter = DS.RESTAdapter.extend(namespace: 'api')

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
Access.ApplicationAdapter = DS.ActiveModelAdapter.extend()
